//
//  ViewController.h
//  weatherClient
//
//  Created by Maksim on 19.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registration.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UILabel *autoLable;
@property (strong, nonatomic) IBOutlet Registration *registrationView;
- (IBAction)submitReg:(id)sender;

@end

