//
//  SettingsViewController.h
//  weatherClient
//
//  Created by Maxim on 03.07.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *changeCity;
@property (weak, nonatomic) IBOutlet UISwitch *offMaxTemp;
@property (weak, nonatomic) IBOutlet UISwitch *offMinTemp;
@property (weak, nonatomic) IBOutlet UISwitch *offDiscr;
@property (weak, nonatomic) IBOutlet UISwitch *offPressure;
@property (weak, nonatomic) IBOutlet UISwitch *offHumidity;
@property (weak, nonatomic) IBOutlet UISwitch *ofWind;
@property (weak, nonatomic) IBOutlet UISwitch *offClouds;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogOut;

@end
