//
//  NativeAdViewController.m
//  TapIt-iOS-Sample
//
//  Created by Carl Zornes on 12/17/14.
//  Copyright (c) 2014 TapIt! by Phunware. All rights reserved.
//

#import "NativeAdViewController.h"
#import "AppDelegate.h"

#define ZONE_ID @"7268" // for example use only, don't use this zone in your app!
@interface NativeAdViewController ()

@end

@implementation NativeAdViewController

@synthesize tiNativeManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestNativeAds];
}

- (void)requestNativeAds {
    tiNativeManager = [[TapItNativeAdManager alloc] init];
    tiNativeManager.delegate = self;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            @"test", @"mode", // enable test mode to test native ads in your app
                            nil];
    
    TapItRequest *request = [TapItRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    [tiNativeManager getAdsForRequest:request withRequestedNumberOfAds:10];
}

- (void)labelTapped {
    [tiNativeManager nativeAdWasTouched:[tiNativeManager.allNativeAds objectAtIndex:0]];
}

#pragma mark -
#pragma mark TapItNativeAdDelegate methods

- (void)tapitNativeAdManagerWillLoadAd:(TapItNativeAdManager *)nativeAdManager {
    NSLog(@"Native Ad Manager is about to check server for ad...");
}

- (void)tapitNativeAdManagerDidLoad:(TapItNativeAdManager *)nativeAdManager {
    NSLog(@"Native Ad Manager has been loaded...");
    TapItNativeAd *newAd = [nativeAdManager.allNativeAds objectAtIndex:0];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(10,50,300,20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.text = newAd.adTitle;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [titleLabel addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel setFrame:CGRectMake(10,70,300,100)];
    textLabel.backgroundColor=[UIColor clearColor];
    textLabel.textColor=[UIColor blackColor];
    textLabel.userInteractionEnabled=YES;
    textLabel.text = newAd.adText;
    [textLabel sizeToFit];
    [self.view addSubview:textLabel];
    [textLabel release];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(10, 90, 300,250)];
    [webview loadHTMLString:newAd.adHTML baseURL:nil];
    [self.view addSubview:webview];
    
    [nativeAdManager logNativeAdImpression:newAd];
    
    NSLog(@"Number of ads: %lu with the first ad's title: %@", (unsigned long)[nativeAdManager.allNativeAds count], newAd.adTitle);
}

- (void)tapitNativeAdManager:(TapItNativeAdManager *)nativeAdManager didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Native Ad Manager failed to load with the following error: %@", error.localizedDescription);
}

- (BOOL)tapitNativeAdManagerActionShouldBegin:(TapItNativeAdManager *)nativeAdManager willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Native Ad was tapped, your UI will be covered up. %@", (willLeave ? @" !!LEAVING APP!!" : @""));
    // minimise app footprint for a better ad experience.
    // e.g. pause game, duck music, pause network access, reduce memory footprint, etc...
    return YES;
}

- (void)tapitNativeAdManagerActionWillFinish:(TapItNativeAdManager *)nativeAdManager {
    NSLog(@"Native Ad is about to be dismissed, get ready!");
}

- (void)tapitNativeAdManagerActionDidFinish:(TapItNativeAdManager *)nativeAdManager {
    NSLog(@"Native Ad is done covering your app, back to normal!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
