#import "WeatherViewController.h"


@interface WeatherViewController ()

@end

@implementation WeatherViewController{
    NSObject *weather;
    NSObject *windSpeed;
    NSObject *cloud;
    NSObject *main;
    Location* location;
    NSString* currentLon;
    NSString* currentLat;
}

- (void)viewDidLoad {
    NSLog(@"WeatherViewController");
    [super viewDidLoad];
    location = [Location sharedManager];
    [location getWeatherToday];
    [self loadData];
    NSLog(@"lon:%@ lat:%@",location.lon,location.lat);
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData{
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=e59ece3932558bbf120fde279c990ff7",location.lat,location.lon]
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                main = [responseObject valueForKey:@"main"];
                cloud = [responseObject valueForKey:@"clouds"];
                windSpeed = [responseObject valueForKey:@"wind"];
                for (NSDictionary *fileDictionary in [responseObject objectForKey:@"weather"]) {
                    self.weatherDisc.text = [fileDictionary valueForKey:@"main"];
                }
                NSLog(@"Response:%@, %@, %@, %@, %@ ,lat:%@, lon:%@",[responseObject valueForKey:@"name"], main, cloud, windSpeed, self.weatherDisc.text, location.lat, location.lon);
                self.city.text = [responseObject valueForKey:@"name"];
                NSLog(@"City: %@", self.city.text);
                self.temp.text = [self celsius:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                NSLog(@"Temp: %@", self.temp.text);
                self.maxTemp.text = [NSString stringWithFormat:@"Max: %@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                NSLog(@"%@", self.maxTemp.text);
                self.minTemp.text = [NSString stringWithFormat:@"Min: %@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                NSLog(@"%@", self.minTemp.text);
                self.pressure.text = [NSString stringWithFormat:@"Pressure: %@", [main valueForKey:@"pressure"]];
                NSLog(@"%@", self.pressure.text);
                self.humidity.text = [NSString stringWithFormat:@"Humidity: %@%%", [main valueForKey:@"humidity"]];
                NSLog(@"%@", self.humidity.text);
                self.clouds.text = [NSString stringWithFormat:@"Clouds: %@%%", [cloud valueForKey:@"all"]];
                self.wind.text =[NSString stringWithFormat:@"Wind: %@ m/s", [windSpeed valueForKey:@"speed"]];
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
    NSLog(@"End of loadData");
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
