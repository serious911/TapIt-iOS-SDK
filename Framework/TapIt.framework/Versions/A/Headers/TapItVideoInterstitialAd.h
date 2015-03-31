//
//  TapItVideoInterstitialAd.h
//  TapIt iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "TVASTAdsRequest.h"
#import "TVASTVideoAdsManager.h"
#import "TVASTAdsLoader.h"
#import "TVASTClickTrackingUIView.h"
#import "TVASTClickThroughBrowser.h"
#import "TapItConstants.h"

@class TapItVideoInterstitialAd, FullScreenVC;

/**
 A `TapItVideoInterstitialAdDelegate` is needed to receive notifications about video ad status.
 */
@protocol TapItVideoInterstitialAdDelegate <NSObject>

@required

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Called when the adsLoader receives a video and is ready to play (required).
 @param videoAd The video ad that was loaded.
 */
- (void)tapitVideoInterstitialAdDidLoad:(TapItVideoInterstitialAd *)videoAd;

/**
 Gets called when the video ad has finished playing and the screen returns to your app.
 @param videoAd The video ad that finished playing.
 */
- (void)tapitVideoInterstitialAdDidFinish:(TapItVideoInterstitialAd *)videoAd;

/**
 Gets called if there are no ads to display.
 @param videoAd The video ad that failed to load.
 @param error The error string detailing why the video ad failed to play.
 */
- (void)tapitVideoInterstitialAdDidFail:(TapItVideoInterstitialAd *)videoAd withErrorString:(NSString *)error;
@end

/**
 `TapItVideoInterstitialAd` implements a standard `TapItVideoInterstitialAd` into your app.
 */
@interface TapItVideoInterstitialAd : NSObject <TVASTAdsLoaderDelegate,
TVASTClickTrackingUIViewDelegate, TVASTVideoAdsManagerDelegate,
TVASTClickThroughBrowserDelegate>

/**
 `TapItVideoInterstitialAd` implements a standard `TapItVideoInterstitialAd` into your app.
 */

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Once an ad has successfully been returned from the server, the `TVASTVideoAdsManager` is created. You need to stop observing and unload the `TVASTVideoAdsManager` upon deallocating this object.
 */
- (void)unloadAdsManager;

/**
 Once `TVASTVideoAdsManager` has an ad ready to play, this is the function you need to call when you are ready to play the ad.
 */
- (void)playVideoFromAdsManager;

/**
 Instantiantes the `TVASTAdsRequest`.
 @param request The ad request with zone information and any custom parameters.
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request;

///-----------------------
/// @name Optional
///-----------------------

/**
 Instantiantes the `TVASTAdsRequest` with a specified `TapItVideoType`.
 @param request The ad request with zone information and any custom parameters.
 @param videoType The type of video being requested (all, pre-roll, mid-roll, post-roll).
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request andVideoType:(TapItVideoType)videoType;

/**
 An `id` used to identify the 'TapItVideoInterstitialAdDelegate' delegate.
 */
@property (assign, nonatomic) id<TapItVideoInterstitialAdDelegate> delegate;

/**
 A `TVASTVideoAdsManager` is the manager of video ads.
 */
@property(nonatomic, retain) TVASTVideoAdsManager *videoAdsManager;

/**
 A `TVASTClickTrackingUIView` handles touch events on the video ad.
 */
@property(nonatomic, retain) TVASTClickTrackingUIView *clickTrackingView;

/**
 The `AVPlayer` will display the video ad.
 */
@property (nonatomic, retain) AVPlayer *adPlayer;

/**
 The `FullScreenVC` will contain the `AVPlayer`.
 */
@property (nonatomic, retain) FullScreenVC *landscapeVC;

/**
 A `UIViewController` is responsible for presenting the video ad (optional).
 */
@property (nonatomic, retain) UIViewController *presentingViewController;

@end
