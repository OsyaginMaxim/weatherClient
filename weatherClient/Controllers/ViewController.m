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
    self.registrationView.passwordField.secureTextEntry = YES;
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
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
            [self performSegueWithIdentifier:@"login" sender:self];
        }else{
            NSLog(@"Token not equal password");
            //TODO reload loginField and passwordField
            //reload: bad version {
            UIAlertController* alert= [UIAlertController alertControllerWithTitle:@"Error!"
                                                                          message:@"Password is not correct." preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action){}];
            [alert addAction:actionOK];
            [self presentViewController:alert animated:YES completion:nil];
            self.registrationView.loginField.text = @"";
            self.registrationView.passwordField.text = @"";
            //TODO alert about error in password
        }
    }else{
        NSLog(@"Token equal nil");
        [keychain setString:self.registrationView.passwordField.text forKey:self.registrationView.loginField.text];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
}



@end
