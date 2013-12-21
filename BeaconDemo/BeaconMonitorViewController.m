//
//  BeaconMonitorViewController.m
//  BeaconDemo
//
//  Created by Hydra on 13-12-21.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "BeaconMonitorViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface BeaconMonitorViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLBeaconRegion* targetBeaconRegion;
@property (nonatomic,strong) CLLocationManager* locationManager;
@end

@implementation BeaconMonitorViewController

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
    self.navigationItem.title = @"Beacon Monitor";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) onBtnStartBeaconMonitor:(id)sender
{
    if(self.targetBeaconRegion == nil)
    {
        NSUUID* myUUID = [[NSUUID alloc] initWithUUIDString:KUUID];
        self.targetBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID identifier:@"My Beacon Demo 20131221"];
    }
    if(self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    if(self.locationManager.rangedRegions.count == 0)
    {
        [self.locationManager startRangingBeaconsInRegion:self.targetBeaconRegion];
    }
    else
    {
        [self.locationManager stopRangingBeaconsInRegion:self.targetBeaconRegion];
    }
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSString* strTips = [NSString stringWithFormat:@"didUpdateToLocation %@ fromLocation %@\r\n",newLocation,oldLocation];
    NSLog(@"%@",strTips);
}
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    NSString* strTips = [NSString stringWithFormat:@"didUpdateLocations %@ \r\n",locations];
    NSLog(@"%@",strTips);
}
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if(beacons == nil || [beacons count] == 0)
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        return;
    }
    NSString* strTips = @"";
    for(CLBeacon* beacon in beacons)
    {
        NSString* des = nil;
        if(beacon.proximity == CLProximityUnknown)
        {
            [self.view setBackgroundColor:[UIColor lightGrayColor]];
            des = @"Unknown";
        }
        else if(beacon.proximity == CLProximityImmediate)
        {
            [self.view setBackgroundColor:[UIColor orangeColor]];
            des = @"Immediate";
        }
        else if(beacon.proximity == CLProximityNear)
        {
            [self.view setBackgroundColor:[UIColor blueColor]];
            des = @"Near";
        }
        else if(beacon.proximity == CLProximityFar)
        {
            [self.view setBackgroundColor:[UIColor redColor]];
            des = @"Far";
        }
        else
        {
            des = @"Unknown";
        }
        NSString* strTemp = [NSString stringWithFormat:@"%@\r\n%f",des,beacon.accuracy];
        strTips = [strTips stringByAppendingString:strTemp];
    }
    [self.textView setText:strTips];
}
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    NSString* strTips = [NSString stringWithFormat:@"didEnterRegion %@ \r\n",region.identifier];
    [self.textView setText:strTips];
}
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    NSString* strTips = [NSString stringWithFormat:@"didExitRegion %@ \r\n",region.identifier];
    [self.textView setText:strTips];
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSString* strTips = [NSString stringWithFormat:@"didChangeAuthorizationStatus %d \r\n",status];
    [self.textView setText:strTips];
}
@end
