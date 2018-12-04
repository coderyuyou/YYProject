//
//  YYToolViewController.m
//  YYProject
//
//  Created by 于优 on 2018/11/30.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYToolViewController.h"
#import "YYProgressHUD.h"

@interface YYToolViewController ()
/** 数据源 */
@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation YYToolViewController

static NSString *const toolCell = @"toolCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createView];
}

- (void)createView {
    
    self.navView.title = @"系统工具";
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
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - setter & getter

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"MBP_HUD", @"AlertView", @"ActionSheet", @"PagingView", @"PickView", @"CalendarView", @"MBP_HUD", @"AlertView", @"ActionSheet", @"PagingView", @"PickView", @"CalendarView"];
    }
    return _dataArray;
}

@end
