//
//  YYBaseViewController.m
//  YYProject
//
//  Created by 于优 on 2018/11/28.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYBaseViewController.h"
#import <MJRefresh.h>

@interface YYBaseViewController () <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBaseViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // 隐藏系统导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //    [self endRefresh:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createBaseViewController {
    
    // 设置动画是否可用
    [UIView setAnimationsEnabled:YES];
    // 取消自动计算
    UIScrollView *scrollView = nil;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]] || [view isKindOfClass:[UICollectionView class]] || [view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)view;
            break;
        }
    }
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 开启统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    // 设置默认背景色
    self.view.backgroundColor = kBackgroundColor;
    
    // 添加自定义导航栏
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kStatusAndNavigationBarHeitht);
    }];
    WEAKSELF;
    self.navView.didNavBtnClickHandle = ^(YYNavBtnClickType type, UIButton * _Nonnull btn) {
        if (type == YYNavBtnClickTypeLeft) {
            [weakSelf navLeftPressed:btn];
        }
        else if (type == YYNavBtnClickTypeRight) {
            [weakSelf navRightPressed:btn];
        }
    };
    
    // 是否隐藏左边按钮
    if ([self isRootViewController]) {
        // 根视图隐藏左边按钮
        self.navView.hiddenLeftBtn = YES;
    }
    else {
        // 非根视图显示左边按钮
        self.navView.hiddenLeftBtn = NO;
    }
}

// 拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 当前控制器是根控制器
    if ([self isRootViewController]) {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点击屏幕取消编辑
    //    [self.view endEditing:YES];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *strID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - Action

- (BOOL)isRootViewController {
    
    if (self.navigationController.childViewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (void)navLeftPressed:(UIButton *)sender {
    
    //    [self.navigationController popViewControllerAnimated:YES];
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)navRightPressed:(UIButton *)sender {
    
    NSLog(@"=> navRightPressed !");
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToIndex:(NSInteger)index {
    if (self.navigationController == nil) return ;
    
    NSInteger navNumber = (int)[[self.navigationController viewControllers]indexOfObject:self];
    if (navNumber > index) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(navNumber - index)] animated:YES];
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadHeaderRefresh:(UIScrollView *)scrollView completion:(void (^)(void))completion {
    
    Class class = NSClassFromString(@"MJRefreshComponent");
    if (!class) {
        NSLog(@"加载上拉失败");
        return;
    }
    if (!scrollView) {
        scrollView = self.tableView;
    }
    // 下拉刷新(进入刷新状态就会调用self的headerRereshing)
    MJRefreshNormalHeader *hearder = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (completion) {
            completion();
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh:scrollView];
        });
    }];
    
    hearder.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = hearder;
}

- (void)beginHeaderRefreshing:(UIScrollView *)scrollView {
    
    Class class = NSClassFromString(@"MJRefreshComponent");
    if (!class) {
        NSLog(@"加载上拉失败");
        return;
    }
    if (!scrollView) {
        scrollView = self.tableView;
    }
    
    //进入刷新状态
    [scrollView.mj_header beginRefreshing];
    
}

- (void)loadFooterRefresh:(UIScrollView *)scrollView completion:(void (^)(void))completion {
    
    Class class = NSClassFromString(@"MJRefreshComponent");
    if (!class) {
        NSLog(@"加载上拉失败");
        return;
    }
    if (!scrollView) {
        scrollView = self.tableView;
    }
    // 上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (completion) {
            completion();
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh:scrollView];
        });
    }];
}

- (void)endRefresh:(UIScrollView *)scrollView {
    if (!scrollView) {
        scrollView = self.tableView;
    }
    if (scrollView.mj_header.state == MJRefreshStateRefreshing) {
        [scrollView.mj_header endRefreshing];
    }
    if (scrollView.mj_footer.state == MJRefreshStateRefreshing) {
        [scrollView.mj_footer endRefreshing];
    }
    
}

- (void)endFooterRefreshWithNoMoreData:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterRefreshWithNoMoreData:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

#pragma mark - setter & getter

- (YYNavigationBarView *)navView {
    if (!_navView) {
        _navView = [YYNavigationBarView shopView];
    }
    return _navView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusAndNavigationBarHeitht, kScreen_Width, kScreen_Height - kStatusAndNavigationBarHeitht) style:UITableViewStyleGrouped];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
