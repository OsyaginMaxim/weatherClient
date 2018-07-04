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
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"viewClouds"]){
        [self.offClouds setOn:NO animated:NO];
    }
    
    // Do any additional setup after loading the view.
}
- (IBAction)offCloudsAction:(id)sender {
    if ([self.offClouds isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"viewClouds"];
        NSLog(@"Switch is off");
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"viewClouds"];
        NSLog(@"Switch is on");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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
