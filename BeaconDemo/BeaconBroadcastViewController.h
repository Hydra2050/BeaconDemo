//
//  BeaconBroadcastViewController.h
//  BeaconDemo
//
//  Created by Hydra on 13-12-21.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconBroadcastViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextView* textView;
-(IBAction) onBtnStartBeaconBroadcast:(id)sender;
@end
