//
//  BeaconBroadcastViewController.m
//  BeaconDemo
//
//  Created by Hydra on 13-12-21.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "BeaconBroadcastViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeaconBroadcastViewController () <CBPeripheralManagerDelegate>
@property (nonatomic,strong) CLBeaconRegion* boardcastBeaconRegion;
@property (nonatomic,strong) CBPeripheralManager* peripheraManager;
@end

@implementation BeaconBroadcastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Beacon Broadcast";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) onBtnStartBeaconBroadcast:(id)sender
{
    if(self.boardcastBeaconRegion == nil)
    {
        NSUUID* myUUID = [[NSUUID alloc] initWithUUIDString:KUUID];
        self.boardcastBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID identifier:@"A Beacon Boradcast"];
    }
    if(self.peripheraManager == nil)
    {
        self.peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    NSDictionary* peripheraData = [self.boardcastBeaconRegion peripheralDataWithMeasuredPower:nil];
    if(self.peripheraManager.state != CBPeripheralManagerStatePoweredOn)
    {
        [self.peripheraManager startAdvertising:peripheraData];
    }
    else
    {
        [self.peripheraManager stopAdvertising];
    }
}
#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSString* strTips = [NSString stringWithFormat:@"peripheralManagerDidUpdateState %d \r\n",peripheral.state];
    strTips = [strTips stringByAppendingString:strTips];
    [self.textView setText:strTips];
    NSLog(@"%d",peripheral.state);
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSString* strTips = [NSString stringWithFormat:@"peripheralManagerDidStartAdvertising %@ \r\n",error];
    strTips = [strTips stringByAppendingString:strTips];
    [self.textView setText:strTips];
    NSLog(@"peripheralManagerDidStartAdvertising with error:%@",error);
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSString* strTips = [NSString stringWithFormat:@"central %@ didSubscribeToCharacteristic %@\r\n",central,characteristic];
    strTips = [strTips stringByAppendingString:strTips];
    [self.textView setText:strTips];
}
-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    NSString* strTips = [NSString stringWithFormat:@"didReceiveReadRequest %@  \r\n",request];
    strTips = [strTips stringByAppendingString:strTips];
    [self.textView setText:strTips];
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    NSString* strTips = [NSString stringWithFormat:@"didReceiveWriteRequests %@ \r\n",requests];
    strTips = [strTips stringByAppendingString:strTips];
    [self.textView setText:strTips];
}
@end
