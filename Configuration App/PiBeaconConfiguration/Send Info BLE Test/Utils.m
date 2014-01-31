//
//  PiBeacon Configuration
//  Copyright (c) 2014 ACompagno. All rights reserved.
//
#include "Utils.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation Utils

- (BOOL)sysVersionEqualTo:(NSString *)version
{
    return SYSTEM_VERSION_EQUAL_TO(version);
}

- (BOOL)sysVersionGreaterThan:(NSString *)version
{
    return SYSTEM_VERSION_GREATER_THAN(version);
}

- (BOOL)sysVersionGreaterThanOrEqualTo:(NSString *)version
{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version);
}

- (BOOL)sysVersionLessThan:(NSString *)version
{
    return SYSTEM_VERSION_LESS_THAN(version);
}

- (BOOL)sysVersionLessThanOrEqualTo:(NSString *)version
{
    return SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version);
}

- (int)getNavBarHeight:(int)navBar withStatusbar:(int)statBar
{
    return [self sysVersionGreaterThanOrEqualTo:@"7.0"] ? navBar + statBar : navBar;
}


@end