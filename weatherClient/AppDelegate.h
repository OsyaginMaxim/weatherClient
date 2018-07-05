//
//  AppDelegate.h
//  weatherClient
//
//  Created by Maksim on 19.06.2018.
//  Copyright © 2018 Maksim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (nonatomic) BOOL alreadyLogIn;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

