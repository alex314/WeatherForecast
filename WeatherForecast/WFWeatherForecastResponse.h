//
//  WFWeatherForecastResponse.h
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFWeatherForecastData.h"

@interface WFWeatherForecastResponse : NSObject

@property (nonatomic, strong, readonly) WFWeatherForecastData *weatherForecastData;
@property (nonatomic, strong, readonly) NSError *error;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;
- (instancetype)initWithError:(NSError *)error;

@end
