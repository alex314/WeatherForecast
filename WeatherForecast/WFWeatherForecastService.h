//
//  WFWeatherForecastService.h
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFWeatherForecastServiceConfig : NSObject

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *appID;

@end

@interface WFWeatherForecastService : NSObject

- (instancetype)initWithWeatherForecastServiceConfig:(WFWeatherForecastServiceConfig *)config;

@end
