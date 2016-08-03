//
//  OEDeviceInfo.m
//  HelloWorld
//
//  Created by Jackson Zhang on 7/20/16.
//
//

#include <sys/sysctl.h>
#import <Cordova/CDV.h>
#import "DeviceLoader.h"
#import "OEDeviceInfo.h"

@interface OEDeviceInfo () {}
@property(nonatomic,strong)DeviceLoader *loader;
@end

@implementation OEDeviceInfo

- (id)init:(DeviceLoader*)loader
{
    self = [super init];
    if (self){
        _loader = loader;
    }
    return self;
}

- (NSDictionary *)properties
{
    UIDevice* device = [_loader load];

    return @{
             @"manufacturer": @"Apple",
             @"model": [self modelVersion],
             @"platform": @"iOS",
             @"version": [device systemVersion],
             @"uuid": [self uniqueAppInstanceIdentifier:device],
             @"cordova": [[self class] cordovaVersion],
             @"isVirtual": @([self isVirtual])
             };
}

- (NSString*)modelVersion
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
}

- (NSString*)uniqueAppInstanceIdentifier:(UIDevice*)device
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    static NSString* UUID_KEY = @"CDVUUID";
    
    // Check user defaults first to maintain backwards compaitibility with previous versions
    // which didn't user identifierForVendor
    NSString* app_uuid = [userDefaults stringForKey:UUID_KEY];
    if (app_uuid == nil) {
        if ([device respondsToSelector:@selector(identifierForVendor)]) {
            app_uuid = [[device identifierForVendor] UUIDString];
        } else {
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            app_uuid = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
            CFRelease(uuid);
        }

        [userDefaults setObject:app_uuid forKey:UUID_KEY];
        [userDefaults synchronize];
    }
    
    return app_uuid;
}

+ (NSString*)cordovaVersion
{
    return CDV_VERSION;
}

- (BOOL)isVirtual
{
    #if TARGET_OS_SIMULATOR
        return true;
    #elif TARGET_IPHONE_SIMULATOR
        return true;
    #else
        return false;
    #endif
}
@end
