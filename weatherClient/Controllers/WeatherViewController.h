//
//  WeatherViewController.h
//  weatherClient
//
//  Created by Maksim on 23.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <AFNetworking.h>
#import <UIKit/UIKit.h>
#import "Weather.h"
#import "WeatherView.h"
#import "Location.h"

@interface WeatherViewController : UIViewController

@property (nonatomic, strong) NSString *cityName;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *maxTemp;
@property (weak, nonatomic) IBOutlet UILabel *minTemp;
@property (weak, nonatomic) IBOutlet UILabel *weatherDisc;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *clouds;

@end
