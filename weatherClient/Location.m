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
    }
    return self;
}

-(CLLocationCoordinate2D) getWeatherLocation{
        location = [[CLLocationManager alloc] init];
        location.delegate = self;
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = kCLDistanceFilterNone;
        [location requestWhenInUseAuthorization];
        [location startUpdatingLocation];
        CLLocation *curLocation = [location location];
        CLLocationCoordinate2D coordinate = [curLocation coordinate];
        NSLog(@"%.3f , %.3f", coordinate.latitude, coordinate.longitude);
        return coordinate;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", locations);
    CLLocation *crnLoc = [locations lastObject];
    locations = [NSArray array];
    self.lon = [NSString stringWithFormat:@"%F", crnLoc.coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%F", crnLoc.coordinate.latitude];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData" object:nil];
    NSLog(@"self.lon: %f, self.lat: %f", crnLoc.coordinate.longitude, crnLoc.coordinate.latitude);
}

@end

