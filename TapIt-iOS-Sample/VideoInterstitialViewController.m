//
//  VideoInterstitialrViewController.m
//  TapIt-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import "VideoInterstitialViewController.h"
#import <TapIt/TVASTAd.h>

// This is the zone id for the InterstitialController example.
// Go to http://ads.tapit.com/ to get one for your app.
// Once a zone is created in the system, it may take up to
// an hour for the zone to be active.

#define ZONE_ID @"22219" // For example use only; don't use this zone in your app!

@implementation VideoInterstitialViewController

@synthesize videoAd;

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
	// Do any additional setup after loading the view.
    self.videoAd = [[TapItVideoInterstitialAd alloc] init];
    self.videoAd.delegate = self;
    
    // Optional... override the presentingViewController (defaults to the delegate)
    //self.videoAd.presentingViewController = self;
}

- (void)viewDidUnload {
    [self.videoAd unloadAdsManager];
    self.videoAd.delegate = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:ZONE_ID];
    [self.videoAd requestAdsWithRequestObject:request];
    
    // If you want to specify the type of video ad you are requesting, use the call below.
    //[self.videoAd requestAdsWithRequestObject:request andVideoType:TapItVideoTypeMidroll];
}

- (IBAction)onRequestAds {
    [self requestAds];
}

#pragma mark -
#pragma mark TapItVideoInterstitialAdDelegate methods

- (void)tapitVideoInterstitialAdDidFinish:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [self.videoAd unloadAdsManager];
}


- (void)tapitVideoInterstitialAdDidLoad:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [self.videoAd playVideoFromAdsManager];
}

- (void)tapitVideoInterstitialAdDidFail:(TapItVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
}
@end
