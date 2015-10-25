//
//  AppDelegate.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "AppDelegate.h"
#import "WFWeatherForecastService.h"
#import "WFMainViewController.h"
#import "WFLocationService.h"

@interface AppDelegate ()

@property (nonatomic, strong) WFWeatherForecastService *weatherForecastService;
@property (nonatomic, strong) WFLocationService *locationService;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self setupServices];
  [self injectDependencies];
  return YES;
}

- (void)setupServices
{
  WFWeatherForecastServiceConfig *config = [WFWeatherForecastServiceConfig new];
  config.baseURL = @"http://api.openweathermap.org/data/2.5/";
  config.appID = @"bd82977b86bf27fb59a04b61b657fb6f";
  self.weatherForecastService = [[WFWeatherForecastService alloc] initWithWeatherForecastServiceConfig:config];

  self.locationService = [WFLocationService new];
}

- (void)injectDependencies
{
  id vc = self.window.rootViewController;
  [vc setWeatherForecastService:self.weatherForecastService];
  [vc setLocationService:self.locationService];
}

@end
