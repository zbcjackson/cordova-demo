//
//  OEDeviceProviderTest.m
//  HelloWorld
//
//  Created by Jackson Zhang on 8/7/16.
//
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import "OEDeviceProvider.h"
#import "CDVDevice.h"
#import "OEDevice.h"

@interface OEDeviceProviderTest : XCTestCase

@end

@implementation OEDeviceProviderTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSendDeviceInfo {
    CDVDevice *plugin = mock([CDVDevice class]);
    OEDevice *device = mock([OEDevice class]);
    [given([device properties]) willReturn:@{@"manufacturer": @"Apple"}];
    OEDeviceProvider *provider = [[OEDeviceProvider alloc] initWithDevice:plugin device:device];
    CDVInvokedUrlCommand *command = [[CDVInvokedUrlCommand alloc] initWithArguments:nil callbackId:@"CALLBACK_ID" className:@"CLASS_NAME" methodName:@"METHOD_NAME"];
    
    [provider getDeviceInfo:command];
    
    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
    [verify(plugin) send:(id)argument callbackId:@"CALLBACK_ID"];
    
    CDVPluginResult *result = argument.value;
    assertThat(result.status, equalTo([NSNumber numberWithInt:CDVCommandStatus_OK]));
    
    NSString *argumentsJson = [result argumentsAsJSON];
    assertThat(argumentsJson, equalTo(@"{\"manufacturer\":\"Apple\"}"));
}

@end
