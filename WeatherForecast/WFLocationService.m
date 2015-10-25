//
//  WFLocationService.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFLocationService.h"

NSString *const WFLocationServiceCurrentLocationDidUpdateNotification = @"WFLocationServiceCurrentLocationDidUpdateNotification";

@interface WFLocationService () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation WFLocationService

- (instancetype)init
{
  if (!(self = [super init])) return nil;
  self.locationManager = [CLLocationManager new];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager startUpdatingLocation];
  return self;
}

- (void)dealloc
{
  [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
  self.currentLocation = [locations firstObject];
  [[NSNotificationCenter defaultCenter] postNotificationName:WFLocationServiceCurrentLocationDidUpdateNotification object:self];
}

@end
