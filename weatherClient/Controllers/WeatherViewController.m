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
    NSObject *name;
    NSObject *weather;
    NSObject *windSpeed;
    NSObject *cloud;
    NSObject *main;
    CLLocationManager *location;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize cityName;

- (void)viewDidLoad {
    NSLog(@"WeatherViewController");
    [super viewDidLoad];
    location = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [self getWeatherToday];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData{
    NSString *encoded = [cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=e59ece3932558bbf120fde279c990ff7", encoded]
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                self->name = [responseObject valueForKey:@"name"];
                self->main = [responseObject valueForKey:@"main"];
                self->cloud = [responseObject valueForKey:@"clouds"];
                self->windSpeed = [responseObject valueForKey:@"wind"];
                self->weather = [responseObject valueForKey:@"weather"];
                NSLog(@"Response: %@, %@, %@, %@, %@", self->name, self->main, self->cloud, self->windSpeed, self->weather);
                self.city.text = self->cityName;
                self.temp.text = [self celsius:[NSString stringWithFormat:@"%@ C", [self->main valueForKey:@"temp"]]];
                self.maxTemp.text = [NSString stringWithFormat:@"Max: %@", [self celsius:[NSString stringWithFormat:@"%@", [self->main valueForKey:@"temp_max"]]]];
                self.minTemp.text = [NSString stringWithFormat:@"Min: %@", [self celsius:[NSString stringWithFormat:@"%@", [self->main valueForKey:@"temp_min"]]]];
                self.pressure.text = [NSString stringWithFormat:@"Pressure: %@", [self->main valueForKey:@"pressure"]];
                self.humidity.text = [NSString stringWithFormat:@"Humidity: %@%%", [self->main valueForKey:@"humidity"]];
                self.clouds.text = [NSString stringWithFormat:@"Clouds: %@%%", [self->cloud valueForKey:@"all"]];
                self.wind.text =[NSString stringWithFormat:@"Wind: %@ m/s", [self->windSpeed valueForKey:@"speed"]];
                NSLog(@"%@",[self->weather valueForKey:@"description"]);
                //self.weatherDisc.text = [NSString stringWithFormat:@"%@", [self->weather valueForKey:@"description"]];
                
                
                //NSString* pattern = @"[a-zA-Z]";        // Хотим искать слова "in" или "or"
                //NSRegularExpressionOptions regexOptions = NSRegularExpressionCaseInsensitive; // Поиск вне зависимости от регистра
                //NSError* error = NULL;
                // Само создание регулярного выражения
                //NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
                //NSString * description = [self->weather valueForKey:@"description"];
                //NSString * regExp = [regex matchesInString:description options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, description.length)];
                //if (error){
                //    NSLog(@"Ошибка при создании Regular Expression"); // Если в pattern были внесены корректные данные, тогда это сообщение не появиться
                //}
                
                
                //self.weatherDisc.text = [NSString stringWithFormat:@"%@", regExp];
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
}
-(NSString*)celsius:(NSString*) kelvin{
    float cels = [kelvin floatValue];
    cels -= 273;
    kelvin = [NSString stringWithFormat:@"%.0f C",cels];
    return kelvin;
}
-(NSString*)fahrenheit:(NSString*) kelvin{
    float fahr = [kelvin floatValue];
    fahr = (fahr-273) * 1.8 + 23;
    kelvin = [NSString stringWithFormat:@"%.0f C", fahr];
    return kelvin;
}

-(void)getWeatherToday{
    if([CLLocationManager locationServicesEnabled]){
        if(!location)
            location = [[CLLocationManager alloc] init];
        location.delegate = self;
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = 100;
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
            self.cityName = self->placemark.locality;
            NSLog(@"%@", self.cityName);
            [self loadData];
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
