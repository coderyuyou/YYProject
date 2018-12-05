//
//  PickViewController.m
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "PickViewController.h"
#import "UIButton+Extension.h"
#import "YYAddressPicker.h"

@interface PickViewController () <YYAddressPickerDelegate>

/**  */
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic,strong) YYAddressPicker *addressPickerView;

@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView {
    
    [self.view addSubview:self.saveBtn];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(80);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    WEAKSELF;
    [self.saveBtn addTargetWithEvents:UIControlEventTouchUpInside actionHandle:^(UIButton *btn) {
        [weakSelf showAddressPickView];
    }];
}

#pragma mark - ***************  Delegate  ***************
//取消事件
- (void)YYAddressPickerCancleAction {
    
    [self.addressPickerView removeFromSuperview];
}
//确定事件
- (void)YYAddressPickerWithProvince:(YYAddressModel *)province city:(YYAddressCityModel *)city area:(YYAddressCountyModel *)area {
    
    [self.saveBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",province.areaName,city.areaName,area.areaName] forState:UIControlStateNormal];
   
    [self.addressPickerView removeFromSuperview];
}

#pragma mark - ***************  Action  ***************

- (void)showAddressPickView {
    
    [self.view endEditing:YES];
    
    self.addressPickerView = [[YYAddressPicker alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    //            [self.addressPickerView updateAddressAtProvince:@"浙江省" city:@"杭州市" town:@"拱墅区"];
    self.addressPickerView.delegate = self;
    self.addressPickerView.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:self.addressPickerView];
}

#pragma mark - ***************  setter & getter  ***************

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"选择地址" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:kFontColor_Theme forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = FONT_SIZE(16);
        _saveBtn.backgroundColor = kFontColor_Lightgary;
    }
    return _saveBtn;
}

@end
