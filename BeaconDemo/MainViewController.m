//
//  MainViewController.m
//  BeaconDemo
//
//  Created by Hydra on 13-12-21.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "MainViewController.h"
#import "BeaconBroadcastViewController.h"
#import "BeaconMonitorViewController.h"

@interface MainViewController ()
{
    NSArray* _aryCellTitleList;
}
@end

@implementation MainViewController

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
    self.navigationItem.title = @"Beacon Demo";
    _aryCellTitleList = @[@"Start Beacon Monitor",@"Start Beacon Broadcast"];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strReuseID = @"BeaconCellReuseID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strReuseID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strReuseID];
    }
    if(indexPath.row < [_aryCellTitleList count])
    {
        cell.textLabel.text = [_aryCellTitleList objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        BeaconMonitorViewController* monitorViewController = [[BeaconMonitorViewController alloc] init];
        [self.navigationController pushViewController:monitorViewController animated:YES];
    }
    else if(indexPath.row == 1)
    {
        BeaconBroadcastViewController* broadcastViewController = [[BeaconBroadcastViewController alloc] init];
        [self.navigationController pushViewController:broadcastViewController animated:YES];
    }
    else
    {
        //...
    }
}
@end
