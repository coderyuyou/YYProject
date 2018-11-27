//
//  YYUIManager.h
//  YYProject
//
//  Created by 于优 on 2018/11/26.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYUIManager : NSObject

+ (instancetype)sharedInstance;

- (void)createMainView:(UIWindow *)window;

@end


