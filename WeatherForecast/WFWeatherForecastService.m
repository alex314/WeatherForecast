//
//  WFWeatherForecastService.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFWeatherForecastService.h"

@interface WFWeatherForecastService ()

@property (nonatomic, strong) WFWeatherForecastServiceConfig *config;
@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation WFWeatherForecastService

- (instancetype)initWithWeatherForecastServiceConfig:(WFWeatherForecastServiceConfig *)config
{
  if (!(self = [super init])) return nil;
  self.config = config;
  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.urlSession = [NSURLSession]
  return self;
}

- (void)requestResponse:(void(^)())response
{
  NSURLSession
}

@end

#pragma mark - WFWeatherForecastServiceConfig

@implementation WFWeatherForecastServiceConfig

@end