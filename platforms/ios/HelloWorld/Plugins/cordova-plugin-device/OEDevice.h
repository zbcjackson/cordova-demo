//
//  OEDeviceInfo.h
//  HelloWorld
//
//  Created by Jackson Zhang on 7/20/16.
//
//

#import <Foundation/Foundation.h>
#import "OEUIDeviceLoader.h"

@interface OEDevice : NSObject

- (id)init:(OEUIDeviceLoader*)loader;
- (NSDictionary *)properties;

@end
