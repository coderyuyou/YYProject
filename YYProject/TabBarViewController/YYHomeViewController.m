//
//  YYHomeViewController.m
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYHomeViewController.h"
#import "YYAlignmentButton.h"
#import "UIButton+Extension.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "UIImage+Extension.h"
#import "YYNetworkUser.h"
#import "YYUnitTextField.h"
#import "CameraViewController.h"
#import "OptimizeCameraViewController.h"

@implementation YYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
//    [self requestData];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1", @"2", @"3", @"2",@"1", @"3", @"3", @"4", nil];
    
    for (NSString *str in [dic allKeys]) {
        if ([str isEqualToString:@"2"]) {
            [dic setObject:@"2" forKey:dic[str]];
        }
    }
    
    YYLog(@"------%@",dic);
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    
    for (NSInteger i = 0; i < array.count; i++) {
        if ([array[i] isEqualToString:@"2"]) {
            [array removeObject:array[i]];
        }
    }
//
//    for (NSString *str in array) {
//        if ([str isEqualToString:@"2"]) {
//            [array removeObjectAtIndex:1];
//        }
//    }
    
//    for (NSString *str in array) {
//        if ([str isEqualToString:@"2"]) {
//            [array removeObject:str];
//        }
//    }
    
    YYLog(@"------%@",array);
}

- (void)requestData {
    [YYNetworkUser requestWithUserInfo:@{} successBlock:^(ResponseModel * _Nonnull response) {
    } failureBlock:^(NSError * _Nonnull error) {
    }];
    
    [YYNetworkUser requestWithCheckMobile:@{@"mobile":@"15167152681"} successBlock:^(ResponseModel * _Nonnull response) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)createView {
    
    self.navView.title = @"首页";
    self.navView.seperateColor = kFontColor_Gray;
    self.tabBarItem.badgeValue = @"2";
    
    YYAlignmentButton *btn = [YYAlignmentButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithHexString:@"7190FF"];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTitleColor:kColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake([UIView fitWidth:140], 50));
    }];
    
    [btn addTargetWithEvents:UIControlEventTouchUpInside actionHandle:^(UIButton *btn) {
        CameraViewController *Vc = [CameraViewController new];
        [self pushVc:Vc];
    }];
}



- (void)createOtherView {
    
    YYUnitTextField *textField = [[YYUnitTextField alloc] initUnitTextFieldWith:YYUnitAlignmentLeft unit:@"¥"];
    textField.backgroundColor = kWhiteColor;
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(140, 50));
    }];
    
    YYAlignmentButton *btn = [YYAlignmentButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithHexString:@"7190FF"];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTitleColor:kColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"contacts"] forState:UIControlStateNormal];
    
    btn.imgAlignment = UIImgAlignmentBottom;
    btn.interval = 8;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake([UIView fitWidth:140], 50));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [btn setLayerBorder:kColor borderWidth:1 borderType:UIBorderSideTypeAll];
        //        [btn setLayerRoundedRect:6];
        [btn setLayerBezierPath:btn.bounds corners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 4)];
    });
    
    [btn addTargetWithEvents:UIControlEventTouchUpInside actionHandle:^(UIButton *btn) {
        
        YYBaseViewController *Vc = [[YYBaseViewController alloc] init];
        [self pushVc:Vc];
    }];
    
    UIImageView *imgView = [UIImageView new];
    imgView.backgroundColor = kFontColor_Gray;
    [self.view addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(btn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(140, 50));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        imgView.image = [UIImage snapshotImageAfterScreenUpdates:YES operateView:btn];
        
        imgView.image = [UIImage snapshotImage:btn];
    });
    
    UIImageView *gradImgView = [UIImageView new];
    //    gradImgView.backgroundColor = kFontColor_Gray;
    [self.view addSubview:gradImgView];
    
    [gradImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(imgView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 80));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        gradImgView.image = [UIImage gradientImageWithBounds:gradImgView.bounds colors:@[kColor, kColor] gradientType:UIGradientTypeTransverse];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}

@end
