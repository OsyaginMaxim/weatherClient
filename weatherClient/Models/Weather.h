//
//  Weather.h
//  weatherClient
//
//  Created by Maksim on 20.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property(nonatomic, strong)NSString* weatherName;
@property(nonatomic, strong)NSString* weatherWind;
@property(nonatomic, strong)NSString* weatherClouds;
@property(nonatomic, strong)NSString* weatherTemp;
@property(nonatomic, strong)NSString* weatherMinTemp;
@property(nonatomic, strong)NSString* weatherMaxTemp;
@property(nonatomic, strong)NSString* weatherPressure;
@property(nonatomic, strong)NSString* weatherHumidity;
@property(nonatomic, strong)NSString* weatherID;
@property(nonatomic, strong)NSString* weatherIcon;
@property(nonatomic, strong)NSString* weatherMain;
@property(nonatomic, strong)NSDate* date;

-(id)initWithJSON:(NSData*)json;


@end
