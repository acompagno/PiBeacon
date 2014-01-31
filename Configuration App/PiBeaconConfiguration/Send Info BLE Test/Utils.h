//
//  PiBeacon Configuration
//  MainViewController.m
//  Copyright (c) 2014 ACompagno. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Utils;

@interface Utils : NSObject

//Check system version
- (BOOL)sysVersionEqualTo:(NSString *)version;
- (BOOL)sysVersionGreaterThan:(NSString *)version;
- (BOOL)sysVersionGreaterThanOrEqualTo:(NSString *)version;
- (BOOL)sysVersionLessThan:(NSString *)version;
- (BOOL)sysVersionLessThanOrEqualTo:(NSString *)version;

//gets the navbar height depending on version
- (int)getNavBarHeight:(int)navBar withStatusbar:(int)statBar;

@end