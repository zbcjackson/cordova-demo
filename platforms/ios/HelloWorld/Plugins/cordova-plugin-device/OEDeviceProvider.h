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
#import "OEDevice.h"

@interface OEDeviceProvider : NSObject

- (id)init:(CDVDevice*)plugin;
- (id)initWithDevice:(CDVDevice*)plugin device:(OEDevice*)device;
- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command;

@end
