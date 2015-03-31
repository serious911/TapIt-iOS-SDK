//
//  TapItNativeAd.h
//  TapIt iOS SDK
//
//
//

#import <Foundation/Foundation.h>

/**
 `TapItNativeAd` implements a standard `TapItNativeAd` into your app.
 */
@interface TapItNativeAd : NSObject

/**
 An `NSString` that contains the ad title for the `TapItNativeAd`.
 */
- (NSString *)adTitle;

/**
 An `NSString` that contains the ad text for the `TapItNativeAd`.
 */
- (NSString *)adText;

/**
 An `NSString` that contains the ad HTML for the `TapItNativeAd`.
 */
- (NSString *)adHTML;

/**
 An `NSNumber` that contains the ad rating for the `TapItNativeAd`.
 */
- (NSNumber *)adRating;

/**
 An `NSString` that contains the ad icon URL for the `TapItNativeAd`.
 */
- (NSString *)adIconURL;

/**
 An `NSString` that contains the ad image URL for the `TapItNativeAd`.
 */
- (NSString *)adImageURL;

/**
 An `NSString` that contains the ad call to action for the `TapItNativeAd`.
 */
- (NSString *)adCTA;

/**
 An `NSString` that contains the ad click URL for the `TapItNativeAd`.
 */
- (NSString *)adClickURL;

/**
 An `NSString` that contains the ad impression URL for the `TapItNativeAd`.
 */
- (NSString *)adImpressionURL DEPRECATED_ATTRIBUTE;

/**
 An `NSArray` that contains the ad impression URLs for the `TapItNativeAd`.
 */
- (NSArray *)adImpressionURLs;

/**
 An `NSString` that contains the ad type for the `TapItNativeAd`.
 */
- (NSString *)adType;

/**
 An `NSString` that contains the ad dimension for the `TapItNativeAd`.
 */
- (NSString *)adDimension;

/**
 An `NSDictionary` that contains all of the native ad data for the `TapItNativeAd`.
 */
- (NSDictionary *)nativeAdData;

@end
