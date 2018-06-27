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
    NSString *name;
    NSObject *weather;
    NSObject *windSpeed;
    NSObject *cloud;
    NSObject *main;
    Location* location;
}

- (void)viewDidLoad {
    NSLog(@"WeatherViewController");
    [super viewDidLoad];
    location = [Location sharedManager];
    self.cityName = [location getWeatherToday];
    [self loadData]; //^ {
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData{
    //dispatch main que
    
    NSString *encoded = [self.cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=e59ece3932558bbf120fde279c990ff7", encoded]
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                
                //TODO распарсить json с key:weather в массив NSMutableArray, затем уже из array[0] вытащить описание по key:discription
                
                name = [responseObject valueForKey:@"name"];
                main = [responseObject valueForKey:@"main"];
                cloud = [responseObject valueForKey:@"clouds"];
                windSpeed = [responseObject valueForKey:@"wind"];
                weather = [responseObject valueForKey:@"weather"];
                NSLog(@"Response: %@, %@, %@, %@, %@", name, main, cloud, windSpeed, weather);
                self.city.text = self.cityName;
                self.temp.text = [self celsius:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                self.maxTemp.text = [NSString stringWithFormat:@"Max: %@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                self.minTemp.text = [NSString stringWithFormat:@"Min: %@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                self.pressure.text = [NSString stringWithFormat:@"Pressure: %@", [main valueForKey:@"pressure"]];
                self.humidity.text = [NSString stringWithFormat:@"Humidity: %@%%", [main valueForKey:@"humidity"]];
                self.clouds.text = [NSString stringWithFormat:@"Clouds: %@%%", [cloud valueForKey:@"all"]];
                self.wind.text =[NSString stringWithFormat:@"Wind: %@ m/s", [windSpeed valueForKey:@"speed"]];
                NSLog(@"%@",weather);
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
