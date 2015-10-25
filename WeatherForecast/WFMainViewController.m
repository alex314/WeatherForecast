//
//  ViewController.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFMainViewController.h"
#import "WFWeatherForecastService.h"
#import "WFWeatherForecastResponse.h"
#import "WFWeatherForecastData.h"
#import "WFLocationService.h"

@interface WFMainViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;

// Data
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *canonicalCities;

// Services
@property (strong, nonatomic) WFWeatherForecastService *weatherForecastService;
@property (strong, nonatomic) WFLocationService *locationService;

@end

@implementation WFMainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadLocations];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationServiceCurrentLocationDidUpdateNotification:) name:WFLocationServiceCurrentLocationDidUpdateNotification object:self.locationService];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:WFLocationServiceCurrentLocationDidUpdateNotification object:nil];
}

- (void)loadLocations
{
  self.cities = @[
                  NSLocalizedString(@"London",nil),
                  NSLocalizedString(@"Paris",nil),
                  NSLocalizedString(@"Tokyo",nil),
                  NSLocalizedString(@"New York",nil),
                  ];
  self.canonicalCities = @[
                  @"London",
                  @"Paris",
                  @"Tokyo",
                  @"New York",
                  ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [self.cities count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
  NSString *name;
  if (indexPath.row == 0) {
    name = NSLocalizedString(@"Current location", nil);
  } else {
    name = self.cities[indexPath.row - 1];
  }
  cell.textLabel.text = name;
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    [self loadWeatherForecastForCurrentLocation];
  } else {
    [self loadWeatherForecastForCity:self.canonicalCities[indexPath.row - 1]];
  }
}

#pragma mark - 

- (BOOL)isSelectedCurrentLocation
{
  NSIndexPath *selectedRow = [self.locationsTableView indexPathForSelectedRow];
  return selectedRow == nil || selectedRow.row == 0;
}

#pragma mark - Loading weather forecast

- (void)loadWeatherForecastForCity:(NSString *)city
{
  self.temperatureLabel.text = NSLocalizedString(@"Loading...", nil);
  __weak typeof(self) weakSelf = self;
  [self.weatherForecastService requestWeatherForecastForCity:city
                                               responseBlock:^(WFWeatherForecastResponse *response) {
                                                 __strong typeof(weakSelf) strongSelf = weakSelf;
                                                 [strongSelf handleWeatherForecastResponse:response];
  }];
}

- (void)loadWeatherForecastForCurrentLocation
{
  CLLocation *currentLocation = self.locationService.currentLocation;
  if (currentLocation == nil) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                        message:NSLocalizedString(@"Cannot determine current location", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    [alertView show];
  } else {
    self.temperatureLabel.text = NSLocalizedString(@"Loading...", nil);
    __weak typeof(self) weakSelf = self;
    [self.weatherForecastService requestWeatherForecastForLocation:currentLocation.coordinate responseBlock:^(WFWeatherForecastResponse *response) {
      __strong typeof(weakSelf) strongSelf = weakSelf;
      [strongSelf handleWeatherForecastResponse:response];
    }];
  }
}

- (void)handleWeatherForecastResponse:(WFWeatherForecastResponse *)response
{
  if (response.error != nil) {
    self.temperatureLabel.text = NSLocalizedString(@"Error", nil);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                        message:response.error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    [alertView show];
  } else {
    self.temperatureLabel.text = [response.weatherForecastData.temperature stringValue];
  }
}

#pragma mark - Notifications

- (void)locationServiceCurrentLocationDidUpdateNotification:(NSNotification *)notification
{
  if ([self isSelectedCurrentLocation]) {
    [self loadWeatherForecastForCurrentLocation];
  }
}

@end
