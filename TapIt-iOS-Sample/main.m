//
//  main.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        int retVal = -1;
        
        @try
        {
            retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"*** Terminating app due to uncaught exception: %@", [exception reason]);
            NSLog(@"Stack trace: %@", [exception callStackSymbols]);
            [exception raise];
        }
        
        return retVal;
    }
}
