//
//  WeatherViewController.m
//  weatherClient
//
//  Created by Maksim on 23.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController{
    CLLocationManager *location;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize country;

- (void)viewDidLoad {
    NSLog(@"WeatherViewController");
    [super viewDidLoad];
    location = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [self getWeatherToday];
    // Do any additional setup after loading the view from its nib.
}

-(void)getWeatherToday{
    // проверяем доступность службы геолокации
    if([CLLocationManager locationServicesEnabled]){
        if(!location)
            location = [[CLLocationManager alloc] init];
        location.delegate = self;
        // задаем наилучшую точность и дистанцию фильтра в 100 метров
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = 100;
        // данный селектор поддерживается только начиная с iOS 8, и его вызов необходим для запуска
        if ([location respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [location requestWhenInUseAuthorization];
        }
        [location startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController* alert= [UIAlertController alertControllerWithTitle:@"Error!"
                                                                  message:@"Failer to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action){}];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* currentLocation = [locations lastObject];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            self->placemark = [placemarks lastObject];
            self.country = self->placemark.locality;
            NSLog(@"%@ %@\n%@ %@\n%@\n%@", self->placemark.subThoroughfare, self->placemark.thoroughfare, self->placemark.postalCode, self->placemark.locality, self->placemark.administrativeArea, self->placemark.country);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
