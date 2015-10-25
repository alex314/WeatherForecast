//
//  WFLocationService.h
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString *const WFLocationServiceCurrentLocationDidUpdateNotification;

@interface WFLocationService : NSObject

- (CLLocation *)currentLocation;

@end
