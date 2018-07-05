//
//  SettingsViewController.m
//  weatherClient
//
//  Created by Maxim on 03.07.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<UITextFieldDelegate>

@end

@implementation SettingsViewController
- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogged"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNoForOffSwitches];
    
    
    // Do any additional setup after loading the view.
}

-(void)setNoForOffSwitches{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewClouds"]){
        [self.offClouds setOn:NO animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewDiscr"]){
        [self.offDiscr setOn:NO animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewWind"]){
        [self.ofWind setOn:NO animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewFahr"]){
        [self.offMaxTemp setOn:NO animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewCelsius"]){
        [self.offMinTemp setOn:NO animated:NO];
        [self.offMaxTemp setOn:YES animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewPressure"]){
        [self.offPressure setOn:NO animated:NO];
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewHumidity"]){
        [self.offHumidity setOn:NO animated:NO];
    }
}

- (IBAction)fahrenheitAction:(id)sender {
    if ([self.offMaxTemp isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewFahr"];
        [self.offMinTemp setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewCelsius"];
        NSLog(@"Switch fahr is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewFahr"];
        [self.offMinTemp setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewCelsius"];
        NSLog(@"Switch fahr is on");
    }
}
- (IBAction)celsiusAction:(id)sender {
    //[self.mySwitch setOn:NO animated:YES];
    if ([self.offMinTemp isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewCelsius"];
        [self.offMaxTemp setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewFahr"];
        NSLog(@"Switch celsius is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewCelsius"];
        [self.offMaxTemp setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewFahr"];
        NSLog(@"Switch celsuis is on");
    }
    
}
- (IBAction)offDiscriptionAction:(id)sender {
    if ([self.offDiscr isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewDiscr"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewDiscr"];
        NSLog(@"Switch is on");
    }
}
- (IBAction)offPressureAction:(id)sender {
    if ([self.offPressure isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewPressure"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewPressure"];
        NSLog(@"Switch is on");
    }
}
    
- (IBAction)offHumidityAction:(id)sender {
    if ([self.offHumidity isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewHumidity"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewHumidity"];
        NSLog(@"Switch is on");
    }
}
    
- (IBAction)offWindAction:(id)sender {
    if ([self.ofWind isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewWind"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewWind"];
        NSLog(@"Switch is on");
    }
}
- (IBAction)offCloudsAction:(id)sender {
    if ([self.offClouds isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewClouds"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewClouds"];
        NSLog(@"Switch is on");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.changeCity.text forKey:@"name"];
    [self.changeCity resignFirstResponder];
    return YES;
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
