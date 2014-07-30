//
//  AdMobController.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 8/27/12.
//
//

#import "GADBannerViewDelegate.h"
#import "GADInterstitialDelegate.h"

typedef enum {
    StateNone = 0,
    StateLoading,
    StateError,
    StateReady,
} ButtonState;

@class GADBannerView, GADInterstitial;

@interface AdMobController : UIViewController <GADBannerViewDelegate, GADInterstitialDelegate> {
    GADBannerView *bannerView_;
    GADInterstitial *interstitial_;
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UIButton *loadButton;
@property (retain, nonatomic) IBOutlet UIButton *showButton;

@end
