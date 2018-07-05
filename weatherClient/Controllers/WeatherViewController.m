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
    CLLocationCoordinate2D coord;
    UIActivityIndicatorView *spinner;
}

- (void)viewDidLoad {
    NSLog(@"WeatherViewController");
    [super viewDidLoad];
    
    location = [Location sharedManager];
    coord = [location getWeatherLocation];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(160,124)];
    [spinner startAnimating];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData)
                                                 name:@"loadData"
                                               object:nil];

    NSLog(@"lon:%@ lat:%@",location.lon,location.lat);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}
    
-(void)loadByCoord{
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=e59ece3932558bbf120fde279c990ff7",location.lat,location.lon]
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                NSError* error;
                NSData* jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                   options:NSJSONWritingPrettyPrinted error:&error];
                Weather* model = [[Weather alloc] initWithJSON:jsonData];
                main = [responseObject valueForKey:@"main"];
                cloud = [responseObject valueForKey:@"clouds"];
                windSpeed = [responseObject valueForKey:@"wind"];
                [spinner stopAnimating];
                for (NSDictionary *fileDictionary in [responseObject objectForKey:@"weather"]) {
                    if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewDiscr"]){
                        self.weatherDisc.text = [fileDictionary valueForKey:@"main"];
                    }else{
                        self.weatherDisc.text = nil;
                    }
                    
                }
                NSLog(@"Response:%@, %@, %@, %@, %@ ,lat:%@, lon:%@",[responseObject valueForKey:@"name"], main, cloud, windSpeed, self.weatherDisc.text, location.lat, location.lon);
                self.city.text = [responseObject valueForKey:@"name"];
                NSLog(@"City: %@", self.city.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewCelsius"]){
                    self.temp.text = [self celsius:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                    NSLog(@"Temp: %@", self.temp.text);
                    self.maxTemp.text = [NSString stringWithFormat:@"%@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                    NSLog(@"%@", self.maxTemp.text);
                    self.minTemp.text = [NSString stringWithFormat:@"%@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                }else{
                    self.temp.text = [self fahrenheit:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                    NSLog(@"Temp: %@", self.temp.text);
                    self.maxTemp.text = [NSString stringWithFormat:@"%@", [self fahrenheit:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                    NSLog(@"%@", self.maxTemp.text);
                    self.minTemp.text = [NSString stringWithFormat:@"%@", [self fahrenheit:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                }
                
                NSLog(@"%@", self.minTemp.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewPressure"]){
                    self.pressure.text = [NSString stringWithFormat:@"Pressure: %@", [main valueForKey:@"pressure"]];
                }else{
                    self.pressure.text = nil;
                }
                
                NSLog(@"%@", self.pressure.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewHumidity"]){
                    self.humidity.text = [NSString stringWithFormat:@"Humidity: %@%%", [main valueForKey:@"humidity"]];
                }else{
                    self.humidity.text = nil;
                }
                
                NSLog(@"%@", self.humidity.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewClouds"]){
                    self.clouds.text = [NSString stringWithFormat:@"Clouds: %@%%", [cloud valueForKey:@"all"]];
                }else{
                    self.clouds.text = nil;
                }
                
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewWind"]){
                    self.wind.text =[NSString stringWithFormat:@"Wind: %.00f m/s", [[windSpeed valueForKey:@"speed"] floatValue]];
                }else{
                    self.wind.text = nil;
                }
                
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
    NSLog(@"End of loadByCoord");
}
    
-(void)loadByCityName{
    NSLog(@"Name: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"name"]);
    NSString *encoded = [[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=e59ece3932558bbf120fde279c990ff7",encoded]
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                NSError* error;
                NSData* jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                   options:NSJSONWritingPrettyPrinted error:&error];
                Weather* model = [[Weather alloc] initWithJSON:jsonData];
                main = [responseObject valueForKey:@"main"];
                cloud = [responseObject valueForKey:@"clouds"];
                windSpeed = [responseObject valueForKey:@"wind"];
                [spinner stopAnimating];
                for (NSDictionary *fileDictionary in [responseObject objectForKey:@"weather"]) {
                    if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewDiscr"]){
                        self.weatherDisc.text = [fileDictionary valueForKey:@"main"];
                    }else{
                        self.weatherDisc.text = nil;
                    }
                    
                }
                NSLog(@"Response:%@, %@, %@, %@, %@ ,lat:%@, lon:%@",[responseObject valueForKey:@"name"], main, cloud, windSpeed, self.weatherDisc.text, location.lat, location.lon);
                self.city.text = [responseObject valueForKey:@"name"];
                NSLog(@"City: %@", self.city.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewCelsius"]){
                    self.temp.text = [self celsius:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                    NSLog(@"Temp: %@", self.temp.text);
                    self.maxTemp.text = [NSString stringWithFormat:@"%@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                    NSLog(@"%@", self.maxTemp.text);
                    self.minTemp.text = [NSString stringWithFormat:@"%@", [self celsius:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                }else{
                    self.temp.text = [self fahrenheit:[NSString stringWithFormat:@"%@ C", [main valueForKey:@"temp"]]];
                    NSLog(@"Temp: %@", self.temp.text);
                    self.maxTemp.text = [NSString stringWithFormat:@"%@", [self fahrenheit:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_max"]]]];
                    NSLog(@"%@", self.maxTemp.text);
                    self.minTemp.text = [NSString stringWithFormat:@"%@", [self fahrenheit:[NSString stringWithFormat:@"%@", [main valueForKey:@"temp_min"]]]];
                }
                
                NSLog(@"%@", self.minTemp.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewPressure"]){
                    self.pressure.text = [NSString stringWithFormat:@"Pressure: %@", [main valueForKey:@"pressure"]];
                }else{
                    self.pressure.text = nil;
                }
                
                NSLog(@"%@", self.pressure.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewHumidity"]){
                    self.humidity.text = [NSString stringWithFormat:@"Humidity: %@%%", [main valueForKey:@"humidity"]];
                }else{
                    self.humidity.text = nil;
                }
                
                NSLog(@"%@", self.humidity.text);
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewClouds"]){
                    self.clouds.text = [NSString stringWithFormat:@"Clouds: %@%%", [cloud valueForKey:@"all"]];
                }else{
                    self.clouds.text = nil;
                }
                
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"viewWind"]){
                    self.wind.text =[NSString stringWithFormat:@"Wind: %.00f m/s", [[windSpeed valueForKey:@"speed"] floatValue]];
                }else{
                    self.wind.text = nil;
                }
                
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
    NSLog(@"End of loadData");
}

-(void)loadData {
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"name"]){
        [self loadByCityName];
    }else{
        [self loadByCoord];
    }
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
    kelvin = [NSString stringWithFormat:@"%.0f F", fahr];
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
