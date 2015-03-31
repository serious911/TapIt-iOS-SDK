//
//  TapItAppTracker.h
//  TapIt iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `TapItAppTracker` implements a standard `TapItAppTracker` into your app. This is required for all ad requests.
 */

@interface TapItAppTracker : NSObject

///-----------------------
/// @name Required Methods
///-----------------------

/**
 This method creates the shared app tracker.
 */
+ (TapItAppTracker *)sharedAppTracker;

/**
 This method registers your application with the ad server.
 */
- (void)reportApplicationOpen;

///---------------
/// @name Other Methods
///---------------

///**
// Returns 'MaaSAdvertising'.
// */
//+ (NSString *)serviceName;

@end
