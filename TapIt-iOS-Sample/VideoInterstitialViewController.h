//
//  VideoInterstitialViewController.h
//  TapIt-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <TapIt/TapItVideoInterstitialAd.h>

@interface VideoInterstitialViewController : UIViewController<TapItVideoInterstitialAdDelegate>

@property (nonatomic, retain) IBOutlet UIButton     *adRequestButton;
@property (nonatomic, retain) TapItVideoInterstitialAd *videoAd;

- (IBAction)onRequestAds;
@end
