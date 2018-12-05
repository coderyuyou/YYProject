//
//  HUDViewController.m
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "HUDViewController.h"
#import "YYProgressHUD.h"
#import "UIView+Extension.h"

@interface HUDViewController ()

/** 数据源 */
@property (nonatomic, strong) NSArray<NSString *> *dataArray;
/**  */
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation HUDViewController

static NSString *const toolCell = @"toolCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}

- (void)createView {
    
    self.navView.title = @"HUD";
    self.navView.seperateColor = kBlackColor;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:toolCell];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view).offset(0);
    }];
}

#pragma mark - TabeView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:toolCell forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [YYProgressHUD showLoadingStyle:YYHUDLoadingStyleDeterminate];
            break;
        case 1:
            [YYProgressHUD showLoadingStyle:YYHUDLoadingStyleDeterminateHorizontalBar];
            break;
        case 2:
            [YYProgressHUD showLoadingStyle:YYHUDLoadingStyleAnnularDeterminate];
            break;
        case 3:
            [YYProgressHUD showPlainText:@"文字提醒" view:self.view];
            break;
        case 4:
            [YYProgressHUD showSuccess:@"已关注" toView:self.view];
            break;
        case 5:
            [YYProgressHUD showError:@"操作失败" toView:self.view];
            break;
        case 6:
            [YYProgressHUD showIcon:[UIImage imageNamed:@"contacts"] message:@"自定义icon"];
            break;
        case 7:
            [YYProgressHUD showCustomView:self.saveBtn hideAfterDelay:1];
            break;
            
        default:
            break;
    }
}

#pragma mark - setter & getter

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"LoadingStyleDeterminate", @"LoadingStyleHorizontalBar", @"LoadingStyleAnnularDeterminate", @"showPlainText", @"showSuccess", @"showError", @"showIcon", @"showCustomView"];
    }
    return _dataArray;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = FONT_SIZE(12);
        _saveBtn.backgroundColor = kFontColor_Theme;
        [_saveBtn setLayerRoundedRect:10];
    }
    return _saveBtn;
}

@end
