//
//  ViewController.m
//  weatherClient
//
//  Created by Maksim on 19.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.registrationView cornerRadiusButton];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitReg:(id)sender {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"vvdev.ru.weatherClient"];
    NSString *token = [keychain stringForKey:self.registrationView.loginField.text];
    if(token != nil){
        NSLog(@"Token not equal nil");
        if(self.registrationView.passwordField.text == token){
            NSLog(@"Token equal password");
            [self performSegueWithIdentifier:@"login" sender:self];
        }else{
            NSLog(@"Token not equal password");
            //todo alert about error in password
        }
    }else{
        NSLog(@"Token equal nil");
        [keychain setString:self.registrationView.passwordField.text forKey:self.registrationView.loginField.text];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
}

//[self performSegueWithIdentifier:@"takeId" sender:indexPath];
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login"]) {
        NSLog(@"segue login");
    }else{
        NSLog(@"segue not found identifier");
    }
}


@end
