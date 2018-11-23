//
//  FZMUIMediator.m
//  FZMGoldExchange
//
//  Created by 吴文拼 on 2018/5/2.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMUIMediator.h"
#import "FZMTabBarViewController.h"

@implementation FZMUIMediator

+ (instancetype)sharedInstance {
    static FZMUIMediator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FZMUIMediator alloc] init];
    });
    
    return instance;
}

- (void)createMainView:(UIWindow *)window {
    
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"fade";
    anim.duration = 1.0;
    [window.layer addAnimation:anim forKey:nil];
   
    FZMTabBarViewController *tabBarVc = [[FZMTabBarViewController alloc] init];
    window.rootViewController = tabBarVc;
    
    [window makeKeyAndVisible];
//    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabBarVc;
//    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}


@end
