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
@import Foundation;

@interface CDVDeviceTest : XCTestCase

@end

@implementation CDVDeviceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    CDVDevice *plugin = mock([CDVDevice class]);
    CDVDeviceInfoProvider *provider = [[CDVDeviceInfoProvider alloc] init:plugin];
    CDVInvokedUrlCommand *command = [[CDVInvokedUrlCommand alloc] initWithArguments:nil callbackId:@"CallbackId" className:@"ClassName" methodName:@"MethodName"];
    
    [provider getDeviceInfo:command];
    
    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
    [verify(plugin) send:(id)argument callbackId:@"CallbackId"];
    
    CDVPluginResult *result = argument.value;
    assertThat(result.status, equalTo([NSNumber numberWithInt:CDVCommandStatus_OK]));

    NSString *argumentsJson = [result argumentsAsJSON];
    NSData *argumentsData = [argumentsJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *arguments = [NSJSONSerialization JSONObjectWithData:argumentsData options:NSJSONReadingMutableLeaves error:&error];
    assertThat(arguments, hasEntry(equalTo(@"manufacturer"), equalTo(@"Apple")));
    assertThat(arguments, hasEntry(equalTo(@"platform"), equalTo(@"iOS")));
    assertThat(arguments, hasEntry(equalTo(@"cordova"), equalTo(@"4.1.1")));
    
    assertThat(argumentsJson, equalTo(@"{\"manufacturer\":\"Apple\",\"platform\":\"iOS\",\"model\":\"x86_64\",\"uuid\":\"F6A167B2-01FB-4319-AC48-B6522EAF0AD4\",\"cordova\":\"4.1.1\",\"version\":\"9.3\",\"isVirtual\":true}"));
}

- (void)testModelAndSystemVersion {
    UIDevice *device = mock([UIDevice class]);
    [given([device systemVersion]) willReturn:@"9.3"];
    DeviceLoader *loader = mock([DeviceLoader class]);
    [given([loader load]) willReturn:device];
    
    
    
    CDVDevice *plugin = mock([CDVDevice class]);
    CDVDeviceInfoProvider *provider = [[CDVDeviceInfoProvider alloc] init:plugin];
    CDVInvokedUrlCommand *command = [[CDVInvokedUrlCommand alloc] initWithArguments:nil callbackId:@"CallbackId" className:@"ClassName" methodName:@"MethodName"];
    
    [provider getDeviceInfo:command];
    
    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
    [verify(plugin) send:(id)argument callbackId:@"CallbackId"];
    
    CDVPluginResult *result = argument.value;

    NSString *argumentsJson = [result argumentsAsJSON];
    NSData *argumentsData = [argumentsJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *arguments = [NSJSONSerialization JSONObjectWithData:argumentsData options:NSJSONReadingMutableLeaves error:&error];
//    assertThat(arguments, hasEntry(equalTo(@"model"), equalTo(@"Apple")));
    assertThat(arguments, hasEntry(equalTo(@"version"), equalTo(@"9.3")));
}

@end
