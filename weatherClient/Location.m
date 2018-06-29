//
//  Location.m
//  weatherClient
//
//  Created by Maxim on 25.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import "Location.h"

@implementation Location{
    CLLocationManager *location;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

+ (id)sharedManager {
    static Location *sharedLocation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocation = [[self alloc] init];
    });
    return sharedLocation;
}

- (id)init {
    if (self = [super init]) {
        location = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
        //someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

-(void)getWeatherToday{
    if([CLLocationManager locationServicesEnabled]){
        if(!location)
            //location = [[CLLocationManager alloc] init];
            location.delegate = self;
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = 100;
        if ([location respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [location requestWhenInUseAuthorization];
        }
        [location startUpdatingLocation];
        self.lat = [NSString stringWithFormat:@"%f", self->location.location.coordinate.latitude];
        self.lon = [NSString stringWithFormat:@"%f", self->location.location.coordinate.longitude];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

-(NSString*)getCityName{
    return self.cityLocation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* currentLocation = [locations lastObject];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.cityLocation = placemark.locality;
            NSLog(@"%@", self.cityLocation);
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}

@end

