//
//  InterstitialController.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapIt/TapIt.h>


typedef enum {
    StateNone = 0,
    StateLoading,
    StateError,
    StateReady,
} ButtonState;

@interface InterstitialController : UIViewController <TapItInterstitialAdDelegate>

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UIButton *loadButton;
@property (retain, nonatomic) IBOutlet UIButton *showButton;

@property (retain, nonatomic) TapItInterstitialAd *interstitialAd;

- (IBAction)loadInterstitial:(id)sender;
- (IBAction)showInterstitial:(id)sender;


- (void)updateUIWithState:(ButtonState)state;
@end
