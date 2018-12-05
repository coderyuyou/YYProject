//
//  YYAlertViewController.h
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAlertAction : NSObject

@property (nonatomic, readonly) NSString *title;

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(YYAlertAction *action))handler;

@end

@interface YYAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<YYAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)addAction:(YYAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
