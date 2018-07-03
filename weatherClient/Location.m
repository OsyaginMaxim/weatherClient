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
        //geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

-(void)getWeatherToday:(void (^) (void))handler{
    /*location = [[CLLocationManager alloc] init];
    if([CLLocationManager locationServicesEnabled]){
        if(!location)
            location.delegate = self;
        location.desiredAccuracy = kCLLocationAccuracyBest;
        [location startUpdatingLocation];
        self.lat = [NSString stringWithFormat:@"%f", self->location.location.coordinate.latitude];
        self.lon = [NSString stringWithFormat:@"%f", self->location.location.coordinate.longitude];
        NSLog(@"Latitude: %@, Longitude: %@", self.lat, self.lon);
        
        //[NSThread sleepForTimeInterval:2.0];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"loadData" object:nil];
     }*/}
-(CLLocationCoordinate2D) getWeatherLocation{
        location = [[CLLocationManager alloc] init];
        location.delegate = self;
        [location requestWhenInUseAuthorization];
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = kCLDistanceFilterNone;
        [location startUpdatingLocation];
        CLLocation *curLocation = [location location];
        CLLocationCoordinate2D coordinate = [curLocation coordinate];
        return coordinate;
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

-(NSString*)getCityName{
    return self.cityLocation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *crnLoc = [locations lastObject];
    //NSLog(@"didUpdateLocations");
    
    [location stopUpdatingLocation];
    self.lon = [NSString stringWithFormat:@"%F", crnLoc.coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%F", crnLoc.coordinate.latitude];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData" object:nil];
    
    NSLog(@"self.lon: %f, self.lat: %f", crnLoc.coordinate.longitude, crnLoc.coordinate.latitude);
}

@end

