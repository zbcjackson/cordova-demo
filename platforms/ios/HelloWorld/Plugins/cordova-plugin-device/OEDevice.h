//
//  OEDeviceInfo.h
//  HelloWorld
//
//  Created by Jackson Zhang on 7/20/16.
//
//

#import <Foundation/Foundation.h>
#import "DeviceLoader.h"

@interface OEDevice : NSObject

- (id)init:(DeviceLoader*)loader;
- (NSDictionary *)properties;

@end
