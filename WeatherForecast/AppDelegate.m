//
//  AppDelegate.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "AppDelegate.h"
#import "WFWeatherForecastService.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) WFWeatherForecastService *weatherForecastService;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [self setupWeatherForecastService];
  [self injectDependencies];
  return YES;
}

- (void)setupWeatherForecastService
{
  WFWeatherForecastServiceConfig *config = [WFWeatherForecastServiceConfig new];
  config.baseURL = @"api.openweathermap.org/data/2.5/";
  config.appID = @"bd82977b86bf27fb59a04b61b657fb6f";
  self.weatherForecastService = [[WFWeatherForecastService alloc] initWithWeatherForecastServiceConfig:config];
}

- (void)injectDependencies
{
  id vc = self.window.rootViewController;
  [vc setWeatherForecastService:self.weatherForecastService];
}

@end
