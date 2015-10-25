//
//  WFWeatherForecastService.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFWeatherForecastService.h"
#import "AFNetworking.h"
#import "WFWeatherForecastResponse.h"

NSString *const WFWeatherForecastServiceErrorDomain = @"WFWeatherForecastServiceErrorDomain";

@interface WFWeatherForecastService ()

@property (nonatomic, strong) WFWeatherForecastServiceConfig *config;
@property (nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationmanager;

@end

@implementation WFWeatherForecastService

- (instancetype)initWithWeatherForecastServiceConfig:(WFWeatherForecastServiceConfig *)config
{
  if (!(self = [super init])) return nil;
  self.config = config;
  self.httpRequestOperationmanager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:config.baseURL]];
  self.httpRequestOperationmanager.operationQueue = [NSOperationQueue new];
  [self requestWithResponseBlock:^(WFWeatherForecastResponse *response) {
    
  }];
  return self;
}

- (void)requestWithResponseBlock:(void(^)(WFWeatherForecastResponse *response))responseBlock
{
  NSParameterAssert(responseBlock != NULL);
  [self.httpRequestOperationmanager GET:@"weather"
                             parameters:[self requestParameters:@{@"q":@"London"}]
                                success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                  responseBlock([[WFWeatherForecastResponse alloc] initWithResponseObject:responseObject]);
  }
                                failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    responseBlock([[WFWeatherForecastResponse alloc] initWithError:error]);
  }];
}

- (NSDictionary *)requestParameters:(NSDictionary *)parameters
{
  NSMutableDictionary *allParameters = [[self defaultRequestParameters] mutableCopy];
  if (parameters != nil) {
    [allParameters addEntriesFromDictionary:parameters];
  }
  return [allParameters copy];
}

- (NSDictionary *)defaultRequestParameters
{
  return @{@"appid": self.config.appID};
}

@end

#pragma mark - WFWeatherForecastServiceConfig

@implementation WFWeatherForecastServiceConfig

@end