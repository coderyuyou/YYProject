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

@interface YYHomeViewController ()

@end

@implementation YYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
}

- (void)createView {
    self.view.backgroundColor = kBackgroundColor;
    
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
        make.size.mas_equalTo(CGSizeMake(140, 50));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [btn setLayerBorder:kColor borderWidth:1 borderType:UIBorderSideTypeAll];
        [btn setLayerRoundedRect:6];
    });
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}

@end
