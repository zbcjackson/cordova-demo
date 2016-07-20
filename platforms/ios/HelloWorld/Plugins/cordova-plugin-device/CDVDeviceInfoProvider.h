//
//  CDVDeviceInfoProvider.h
//  HelloWorld
//
//  Created by Jackson Zhang on 7/13/16.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "CDVDevice.h"
#import "OEDeviceInfo.h"

@interface CDVDeviceInfoProvider : NSObject

- (id)init:(CDVDevice*)plugin;
- (id)initWithDevice:(CDVDevice*)plugin device:(OEDeviceInfo*)device;
- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command;

@end
