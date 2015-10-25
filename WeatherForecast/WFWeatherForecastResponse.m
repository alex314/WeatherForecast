//
//  WFWeatherForecastResponse.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFWeatherForecastResponse.h"
#import "WFWeatherForecastService.h"

@interface WFWeatherForecastResponse ()

@property (nonatomic, strong) WFWeatherForecastData *weatherForecastData;
@property (nonatomic, strong) NSError *error;

@end

@implementation WFWeatherForecastResponse

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject
{
  if (!(self = [super init])) return nil;
  WFWeatherForecastData *weatherForecastData = [WFWeatherForecastData new];
  NSError *parseError = [NSError errorWithDomain:WFWeatherForecastServiceErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey : @"Incorrect response"}];
  if (![responseObject isKindOfClass:[NSDictionary class]]) {
    return [self initWithError:parseError];
  }
  NSDictionary *main = responseObject[@"main"];
  if (![main isKindOfClass:[NSDictionary class]]) {
    return [self initWithError:parseError];
  }
  NSNumber *temp = main[@"temp"];
  if (![temp isKindOfClass:[NSNumber class]]) {
    return [self initWithError:parseError];
  }
  weatherForecastData.temperature = temp;
  self.weatherForecastData = weatherForecastData;
  self.error = nil;
  return self;
}

- (instancetype)initWithError:(NSError *)error
{
  if (!(self = [super init])) return nil;
  self.error = error;
  return self;
}

@end
