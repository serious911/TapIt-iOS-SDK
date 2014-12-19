//
//  NativeAdViewController.h
//  TapIt-iOS-Sample
//
//  Created by Carl Zornes on 12/17/14.
//  Copyright (c) 2014 TapIt! by Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <TapIt/TapIt.h>

@interface NativeAdViewController : UIViewController <TapItNativeAdDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    NSArray *offices;
    NSIndexPath *currentIndexPath;
    IBOutlet UITableView *customTable;
    BOOL didGetAd;
}

@property (nonatomic, retain) TapItNativeAdManager *tiNativeManager;

@end
