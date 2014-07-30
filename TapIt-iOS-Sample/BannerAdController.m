//
//  BannerAdController.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "BannerAdController.h"
#import "AppDelegate.h"
#import <TapIt/TapIt.h>

// This is the zone id for the BannerAdController example.
// Go to http://ads.tapit.com/ to get one for your app.
// Once a zone is created in the system, it may take up to
// an hour for the zone to be active.

#define ZONE_ID @"7268" // For example use only; don't use this zone in your app!

@implementation BannerAdController

@synthesize tapitAd;

/**
 * This is the easiest way to add banner ads to your app.
 */
- (void)initBannerSimple {
    // Init banner and add to your view
    if (!self.tapitAd) {
        // don't re-define if we used IB to init the banner...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.tapitAd = [[TapItBannerAdView alloc] initWithFrame:CGRectMake(20, 89, 728, 90)];
        } else {
            self.tapitAd = [[TapItBannerAdView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        }
        [self.view addSubview:self.tapitAd];
    }

    // kick off banner rotation!
    [self.tapitAd startServingAdsForRequest:[TapItRequest requestWithAdZone:ZONE_ID]];
}

/**
 * A more advanced example that shows how to:
 * - Enable ad lifecycle notifications
 * - Turn on test mode
 * - Enable GPS based geo-targeting
 */
- (void)initBannerAdvanced {
    // init banner and add to your view
    if (!self.tapitAd) {
        // Don't re-define if we used IB to init the banner...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.tapitAd = [[TapItBannerAdView alloc] initWithFrame:CGRectMake(20, 89, 728, 90)];
        } else {
            self.tapitAd = [[TapItBannerAdView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        }
        
        [self.view addSubview:self.tapitAd];
    }
    
    // Get notifiactions of ad lifecycle events (will load, did load, error, etc...)
    self.tapitAd.delegate = self;

    // BETA: Show a loading overlay when ad is pressed
    self.tapitAd.showLoadingOverlay = YES;

    // Set the parent controller for modal browser that loads when user taps ad
    self.tapitAd.presentingController = self; // Only needed if tapping banner doesn't load the modal browser properly
    
    // Customize the request...
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            @"test", @"mode", // Enable test mode to test banner ads in your app
                            nil];
    TapItRequest *request = [TapItRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    
    // This is how you enable location updates... NOTE: only enable if your app has a good reason to know the users location (Apple will reject your app if not)
    AppDelegate *myAppDelegate = (AppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    
    // kick off banner rotation!
    [self.tapitAd startServingAdsForRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Easiest way to get banners displaying in your app...
//    [self initBannerSimple];
    
//    // - OR - the more advanced way... (Use simple or advanced, but not both!)
    [self initBannerAdvanced];
}

- (IBAction)hideBanner:(id)sender {
    [self.tapitAd hide];
}

- (IBAction)cancelLoad:(id)sender {
    [self.tapitAd cancelAds];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tapitAd resume];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.tapitAd pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // notify banner of orientation changes
    [self.tapitAd repositionToInterfaceOrientation:toInterfaceOrientation];
}

#pragma mark -
#pragma mark TapItBannerAdViewDelegate methods

- (void)tapitBannerAdViewWillLoadAd:(TapItBannerAdView *)bannerView {
    NSLog(@"Banner is about to check server for ad...");
}

- (void)tapitBannerAdViewDidLoadAd:(TapItBannerAdView *)bannerView {
    NSLog(@"Banner has been loaded...");
    // Banner view will display automatically if docking is enabled
    // if disabled, you'll want to show bannerView
}

- (void)tapitBannerAdView:(TapItBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner failed to load with the following error: %@", error);
    // Banner view will hide automatically if docking is enabled
    // if disabled, you'll want to hide bannerView
}

- (BOOL)tapitBannerAdViewActionShouldBegin:(TapItBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Banner was tapped, your UI will be covered up. %@", (willLeave ? @" !!LEAVING APP!!" : @""));
    // Minimize app footprint for a better ad experience.
    // e.g. pause game, duck music, pause network access, reduce memory footprint, etc...
    return YES;
}

- (void)tapitBannerAdViewActionWillFinish:(TapItBannerAdView *)bannerView {
    NSLog(@"Banner is about to be dismissed, get ready!");
    
}

- (void)tapitBannerAdViewActionDidFinish:(TapItBannerAdView *)bannerView {
    NSLog(@"Banner is done covering your app, back to normal!");
    // Resume normal app functions
}

#pragma mark -

- (void)dealloc {
    self.tapitAd = nil;
    [super dealloc];
}

@end
