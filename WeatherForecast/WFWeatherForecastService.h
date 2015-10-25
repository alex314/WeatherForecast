//
//  WFWeatherForecastService.h
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class WFWeatherForecastResponse;

@interface WFWeatherForecastServiceConfig : NSObject

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *appID;

@end

extern NSString *const WFWeatherForecastServiceErrorDomain;

@interface WFWeatherForecastService : NSObject

- (instancetype)initWithWeatherForecastServiceConfig:(WFWeatherForecastServiceConfig *)config;

- (void)requestWeatherForecastForLocation:(CLLocationCoordinate2D)location
                            responseBlock:(void(^)(WFWeatherForecastResponse *response))responseBlock;
- (void)requestWeatherForecastForCity:(NSString *)city
                        responseBlock:(void(^)(WFWeatherForecastResponse *response))responseBlock;

@end
