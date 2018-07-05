//
//  Weather.m
//  weatherClient
//
//  Created by Maksim on 20.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import "Weather.h"

@implementation Weather{
    NSData* data;
}



-(id)initWithJSON:(NSData*)json {
    self = [super init];
    if(self)
    {
        data = json;
        NSError* error;
        NSDictionary* jsonDic = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        NSMutableArray* arrayMain = [jsonDic objectForKey:@"main"];
        NSMutableArray* arrayWeather = [jsonDic objectForKey:@"weather"];
        NSMutableArray* arrayClouds = [jsonDic objectForKey:@"clouds"];
        NSMutableArray* arrayWind = [jsonDic objectForKey:@"wind"];
        self.weatherClouds = [arrayClouds valueForKey:@"all"];
        self.weatherWind = [arrayWind valueForKey:@"speed"];
        self.weatherID = [arrayWeather valueForKey:@"id"];
        self.weatherIcon = [arrayWeather valueForKey:@"icon"];
        self.weatherMain = [arrayWeather valueForKey:@"main"];
        self.weatherTemp = [arrayMain valueForKey:@"temp"];
        self.weatherMaxTemp = [arrayMain valueForKey:@"temp_max"];
        self.weatherMinTemp = [arrayMain valueForKey:@"temp_min"];
        self.weatherHumidity = [arrayMain valueForKey:@"humidity"];
        self.weatherPressure = [arrayMain valueForKey:@"pressure"];
        self.weatherName = [jsonDic valueForKey:@"name"];
        NSLog(@"weatherTemp: %@, weatherName: %@", self.weatherTemp, self.weatherName);
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.date = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"Date: %@", self.date);
    }
    return self;
}



@end
