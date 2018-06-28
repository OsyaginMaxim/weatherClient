//
//  Location.h
//  weatherClient
//
//  Created by Maxim on 25.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface Location : NSObject <CLLocationManagerDelegate>

@property(nonatomic, retain) NSString* cityLocation;
-(NSString*)getCityName;
-(void)getWeatherToday;
+(id) sharedManager;

@property(nonatomic, strong) NSString *lat;
@property(nonatomic, strong) NSString *lon;

@end
