//
//  WeatherViewController.h
//  weatherClient
//
//  Created by Maksim on 23.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController <CLLocationManagerDelegate>

@property(nonatomic, strong) NSString * cityName;

@end
