//
//  YYUIManager.m
//  YYProject
//
//  Created by 于优 on 2018/11/26.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYUIManager.h"
#import "YYTabBarController.h"

@implementation YYUIManager

+ (instancetype)sharedInstance {
    static YYUIManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YYUIManager alloc] init];
    });
    
    return instance;
}

- (void)createMainView:(UIWindow *)window {
    
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"fade";
    anim.duration = 1.0;
    [window.layer addAnimation:anim forKey:nil];
    
    YYTabBarController *tabBarVc = [[YYTabBarController alloc] init];
    window.rootViewController = tabBarVc;
    
    [window makeKeyAndVisible];
    //    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabBarVc;
    //    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}


@end
