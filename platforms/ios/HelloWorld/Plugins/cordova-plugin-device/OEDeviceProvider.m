//
//  CDVDeviceInfoProvider.m
//  HelloWorld
//
//  Created by Jackson Zhang on 7/13/16.
//
//

#import "OEDeviceProvider.h"
#import "CDVDevice.h"
#import "OEDevice.h"


@interface OEDeviceProvider () {}
@property(nonatomic,strong)CDVDevice *plugin;
@property(nonatomic,strong)OEDevice *device;
@end

@implementation OEDeviceProvider

- (id)init:(CDVDevice*)plugin
{
    return [self initWithDevice:plugin device:[[OEDevice alloc] init]];
}

- (id)initWithDevice:(CDVDevice*)plugin device:(OEDevice*)device
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
