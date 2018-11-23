//
//  FZMUIMediator.h
//  FZMGoldExchange
//
//  Created by 吴文拼 on 2018/5/2.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FZMUIMediator : NSObject

+ (instancetype)sharedInstance;

- (void)createMainView:(UIWindow *)window;


@end
