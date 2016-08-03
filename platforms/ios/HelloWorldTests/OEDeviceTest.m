//
//  CDVDeviceTest.m
//  HelloWorld
//
//  Created by Jackson Zhang on 7/10/16.
//
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import "CDVDeviceInfoProvider.h"
#import "CDVDevice.h"
#import "DeviceLoader.h"
#import "OEDeviceInfo.h"
@import Foundation;

@interface OEDeviceTest : XCTestCase

@end

@implementation OEDeviceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    UIDevice *uiDevice = mock([UIDevice class]);
    [given([uiDevice systemVersion]) willReturn:@"9.3"];
    DeviceLoader *loader = mock([DeviceLoader class]);
    [given([loader load]) willReturn:uiDevice];
    OEDeviceInfo *device = [[OEDeviceInfo alloc] init:loader];
    
    NSDictionary *properties = [device properties];
    
//    [provider getDeviceInfo:command];
//    
//    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
//    [verify(plugin) send:(id)argument callbackId:@"CallbackId"];
//    
//    CDVPluginResult *result = argument.value;
//    assertThat(result.status, equalTo([NSNumber numberWithInt:CDVCommandStatus_OK]));
//
//    NSString *argumentsJson = [result argumentsAsJSON];
//    NSData *argumentsData = [argumentsJson dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSDictionary *arguments = [NSJSONSerialization JSONObjectWithData:argumentsData options:NSJSONReadingMutableLeaves error:&error];
    assertThat(properties, hasEntry(equalTo(@"manufacturer"), equalTo(@"Apple")));
    assertThat(properties, hasEntry(equalTo(@"platform"), equalTo(@"iOS")));
    assertThat(properties, hasEntry(equalTo(@"cordova"), equalTo(@"4.1.1")));
    
//    assertThat(argumentsJson, equalTo(@"{\"manufacturer\":\"Apple\",\"platform\":\"iOS\",\"model\":\"x86_64\",\"uuid\":\"F6A167B2-01FB-4319-AC48-B6522EAF0AD4\",\"cordova\":\"4.1.1\",\"version\":\"9.3\",\"isVirtual\":true}"));
}

- (void)testModelAndSystemVersion {
    UIDevice *uiDevice = mock([UIDevice class]);
    [given([uiDevice systemVersion]) willReturn:@"9.3"];
    DeviceLoader *loader = mock([DeviceLoader class]);
    [given([loader load]) willReturn:uiDevice];
    OEDeviceInfo *device = [[OEDeviceInfo alloc] init:loader];
    
    NSDictionary *properties = [device properties];
//    assertThat(properties, hasEntry(equalTo(@"model"), equalTo(@"Apple")));
    assertThat(properties, hasEntry(equalTo(@"version"), equalTo(@"9.3")));
}

@end
