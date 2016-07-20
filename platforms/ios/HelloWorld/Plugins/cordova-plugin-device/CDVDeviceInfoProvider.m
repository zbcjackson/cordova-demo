//
//  CDVDeviceInfoProvider.m
//  HelloWorld
//
//  Created by Jackson Zhang on 7/13/16.
//
//

#import "CDVDeviceInfoProvider.h"
#import "CDVDevice.h"
#import "OEDeviceInfo.h"


@interface CDVDeviceInfoProvider () {}
@property(nonatomic,strong)CDVDevice *plugin;
@property(nonatomic,strong)OEDeviceInfo *device;
@end

@implementation CDVDeviceInfoProvider

- (id)init:(CDVDevice*)plugin
{
    return [self initWithDevice:plugin device:[[OEDeviceInfo alloc] init]];
}

- (id)initWithDevice:(CDVDevice*)plugin device:(OEDeviceInfo*)device
{
    self = [super init];
    if (self){
        _plugin = plugin;
        _device = device;
    }
    return self;
}

- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSDictionary* deviceProperties = [_device properties];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceProperties];

    [_plugin send:pluginResult callbackId:command.callbackId];
}

@end
