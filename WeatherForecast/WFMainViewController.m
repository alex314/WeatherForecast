//
//  ViewController.m
//  WeatherForecast
//
//  Created by Alexey Naumov on 25/10/15.
//  Copyright © 2015 Alexey Naumov. All rights reserved.
//

#import "WFMainViewController.h"
#import "WFWeatherForecastService.h"

@interface WFMainViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

// Data
@property (strong, nonatomic) NSArray *locations;

// Services
@property (strong, nonatomic) WFWeatherForecastService *weatherForecastService;

@end

@implementation WFMainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadLocations];
}

- (void)loadLocations
{
  self.locations = @[
                     @"Current location",
                     @"London",
                     @"Paris",
                     @"Tokyo",
                     @"New York",
                     ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
  cell.textLabel.text = self.locations[indexPath.row];
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

@end
