TapIt iOS SDK
=============

Version 3.1.1

This is the iOS SDK for the TapIt! mobile ad network.  Go to http://tapit.com/ for more details and to sign up.


Usage:
------
To install, drag the [TapIt.framework](https://github.com/tapit/TapIt-iOS-SDK/tree/master/Framework/TapIt.framework "TapIt.framework") and [TapIt.bundle](https://github.com/tapit/TapIt-iOS-SDK/tree/master/Framework/TapIt.bundle "TapIt.bundle") files into your Xcode project.

The following frameworks are required:
````
SystemConfiguration.framework
QuartsCore.framework
CoreTelephony.framework
MessageUI.framework
EventKit.framework
EventKitUI.framework
CoreMedia.framework
AVFoundation.framework
MediaPlayer.framework
AudioToolbox.framework
AdSupport.framework - enable support for IDFA
StoreKit.framework - enable use of SKStoreProductViewController, displays app store ads without leaving your app

CoreLocation.framework - Optional *
````
*Note: CoreLocation is optional, and is used for Geo-targeting ads.  Apple mandates that your app have a good reason for enabling Location services... Apple will deny your app if location is not a core feature for your app.

You're all set!


Initialization
------------

````objective-c
//In your AppDelegate.m file:
#import <TapIt/TapItAppTracker.h>
...
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TapItAppTracker *appTracker = [TapItAppTracker sharedAppTracker];
    [appTracker reportApplicationOpen];
    return YES;
}
````

Banner Usage
------------
````objective-c
// in your .h file
#import <TapIt/TapItBannerAdView.h>

@property (retain, nonatomic) TapItBannerAdView *tapitAd;

...

// in your .m file
#import <TapIt/TapIt.h>
...
// init banner and add to your view
self.tapitAd = [[TapItBannerAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
[self.view addSubview:self.tapitAd];

// kick off banner rotation!
[self.tapitAd startServingAdsForRequest:[TapItRequest requestWithAdZone:@"*YOUR ZONE ID*"]];

...

// We don't want to show ads any more...
[self.tapitAd hide];
[self.tapitAd cancelAds];
````

For a complete example, see https://github.com/tapit/TapIt-iOS-SDK/blob/master/TapIt-iOS-Sample/BannerAdController.m

Interstitial Usage
------------------
Show modally
````objective-c
// in your .h file
#import <TapIt/TapIt.h>
...
@property (retain, nonatomic) TapItInterstitialAd *interstitialAd;

...

// in your .m file

// init and load interstitial
self.interstitialAd = [[[TapItInterstitialAd alloc] init] autorelease];
self.interstitialAd.delegate = self; // notify me of the interstitial's state changes
TapItRequest *request = [TapItRequest requestWithAdZone:@"*YOUR ZONE ID*"];
[self.interstitialAd loadInterstitialForRequest:request];

...

- (void)tapitInterstitialAdDidLoad:(TapItInterstitialAd *)interstitialAd {
    // Ad is ready for display... show it!
    [self.interstitialAd presentFromViewController:self];
}
````
For a complete example, see https://github.com/tapit/TapIt-iOS-SDK/blob/master/TapIt-iOS-Sample/InterstitialController.m

Include in paged navigation
    
````objective-c
@property (retain, nonatomic) TapItInterstitialAd *interstitialAd;

...

// init and load interstitial
self.interstitialAd = [[[TapItInterstitialAd alloc] init] autorelease];
TapItRequest *request = [TapItRequest requestWithAdZone:@"*YOUR ZONE ID*"];
[self.interstitialAd loadInterstitialForRequest:request];

...

// if interstitial is ready, show
if( self.interstitialAd.isLoaded ) {
    [self.interstitialAd presentInView:self.view];
}
````

Video Ads Usage
----------------

For sample video ads integration code, please see the VideoInterstitialViewController.h and VideoInterstitialViewController.m
files for working example of video ads in an app.  You can find VideoInterstitialViewController in the 
TapIt-iOS-Sample directory of the iOS SDK package.

In requesting for a video ad from the server, a TVASTAdsRequest object needs to be instantiated 
and its zoneId parameter specified.  This parameter is required for a successful
retrieval of the ad.  
    
    // Create an adsRequest object and request ads from the ad server with your own kZoneIdVideo
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:kZoneIdVideo;
    [self.videoAd requestAdsWithRequestObject:request];

If you want to specify the type of video ad you are requesting, use the call below.  
    
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:kZoneIdVideo];
    [self.videoAd requestAdsWithRequestObject:request andVideoType:TapItVideoTypeMidroll];
    
Essentially, what needs to be included in the code is as follows:
Note: the following uses Automatic Reference Counting so there will not be any object releases shown.

````objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.videoAd = [[TapItVideoInterstitialAd alloc] init];
    self.videoAd.delegate = self;
    
    // Optional... override the presentingViewController (defaults to the delegate)
    //self.videoAd.presentingViewController = self;        

    [self requestAds];
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own kZoneIdVideo
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:kZoneIdVideo];
    [self.videoAd requestAdsWithRequestObject:request];
    
    //If you want to specify the type of video ad you are requesting, use the call below.
    //[self.videoAd requestAdsWithRequestObject:request andVideoType:TapItVideoTypeMidroll];
}

- (void)tapitVideoInterstitialAdDidFinish:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [self.videoAd unloadAdsManager];
}

- (void)viewDidUnload {
    [self.videoAd unloadAdsManager];
    [super viewDidUnload];
}

- (void)tapitVideoInterstitialAdDidLoad:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [self.videoAd playVideoFromAdsManager];
}

- (void)tapitVideoInterstitialAdDidFail:(TapItVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
}
````

Native Ad Usage
----------------

````objective-c
// in your .h file
#import <TapIt/TapItNativeAdManager.h>

@interface MyViewController : UIViewController <TapItNativeAdDelegate>

@property (nonatomic, retain) TapItNativeAdManager *tiNativeManager;
...

// in your .m file
#import <TapIt/TapIt.h>
...
tiNativeManager = [[TapItNativeAdManager alloc] init];
tiNativeManager.delegate = self;
TapItRequest *request = [TapItRequest requestWithAdZone:*YOUR ZONE ID* andCustomParameters:params];
[tiNativeManager getAdsForRequest:request withRequestedNumberOfAds:10];
...

- (void)tapitNativeAdManagerDidLoad:(TapItNativeAdManager *)nativeAdManager {
    TapItNativeAd *newAd = [nativeAdManager.allNativeAds objectAtIndex:0];

    // Get data from `newAd` and add fields to your view
    ...
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(10,50,300,20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.text = newAd.adTitle;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    ...

    // Add a touch recognizer to native element(s) to enable landing page access
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [titleLabel addGestureRecognizer:tapGestureRecognizer];
    // Log the native ad impression

    [nativeAdManager logNativeAdImpression:newAd];
}

- (void)labelTapped {
    TapItNativeAd *newAd = [tiNativeManager.allNativeAds objectAtIndex:0];
    [tiNativeManager nativeAdWasTouched:newAd];
}

- (void)tapitNativeAdManager:(TapItNativeAdManager *)nativeAdManager didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Native Ad Manager failed to load with the following error: %@", error.localizedDescription);
}
...
````

For a complete example, see https://github.com/tapit/TapIt-iOS-SDK/blob/master/TapIt-iOS-Sample/NativeAdViewController.m

Listen for location updates
---------------------------

If you want to allow for geo-targeting, listen for location updates in your AppDelegate:
````objective-c
@property (retain, nonatomic) CLLocationManager *locationManager;

...
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	TapItAppTracker *appTracker = [TapItAppTracker sharedAppTracker];
    [appTracker reportApplicationOpen];
	// start listening for location updates
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;

    // iOS 8 check
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}
...

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Stop monitoring location when done to conserve battery life
	[self.locationManager stopMonitoringSignificantLocationChanges];
}
...

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.locationManager startMonitoringSignificantLocationChanges];
}
...

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.locationManager stopMonitoringSignificantLocationChanges];
}
...

````

Then, in your ad request, do the following:
````objective-c
	TapItRequest *request = [TapItRequest requestWithAdZone:*YOUR ZONE ID*];
	AppDelegate *myAppDelegate = (AppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    
````