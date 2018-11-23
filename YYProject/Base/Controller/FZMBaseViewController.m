//
//  FZMBaseViewController.m
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/23.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMBaseViewController.h"

#import "MJRefresh.h"

@interface FZMBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation FZMBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createBaseViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
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
    
    [UIView setAnimationsEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = kBackgroundColor;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self initNavView];
}

- (void)initNavView {
    
    // 导航栏
    [self.view addSubview:self.navView];
    // 左按钮
    [self.navView addSubview:self.navLeftBtn];
    // 右按钮
    [self.navView addSubview:self.navRightBtn];
    // 标题
    [self.navView addSubview:self.navTitleLab];
    // 分割线
    [self.navView addSubview:self.navSeperateLine];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kStatusAndNavigationBarHeitht);
    }];

    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.left.equalTo(self.navView).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.right.equalTo(self.navView).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.navTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.right.left.equalTo(self.navView).offset(70);
        make.height.mas_equalTo(40);
    }];
    
    [self.navSeperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.navView).offset(0);
        make.right.left.equalTo(self.navView).offset(70);
        make.height.mas_equalTo(1);
    }];
    
    // 开启统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

// 拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 当前控制器是根控制器
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
}

#pragma mark - ***************  tableView  ***************

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
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
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


#pragma mark - ***************  Action  ***************
/**
 *  导航左按钮事件（默认返回上一页）
 */
- (void)navLeftPressed {
    
//    [self.navigationController popViewControllerAnimated:YES];
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

/**
 *  导航右按钮事件（默认无内容）
 */
- (void)navRightPressed:(id)sender {
    
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
    [self presentVc:vc completion:nil];
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

/**
 *  上拉加载 数据加载完毕
 */
- (void)endFooterRefreshWithNoMoreData:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**
 *  上拉加载 恢复上拉加载
 */
- (void)resetFooterRefreshWithNoMoreData:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

#pragma mark - ***************  setter & getter  ***************

- (UIImageView *)navView {
    if (!_navView) {
        _navView = [[UIImageView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.userInteractionEnabled = YES;
    }
    return _navView;
}

- (UILabel *)navTitleLab {
    if (!_navTitleLab) {
        _navTitleLab = [[UILabel alloc] init];
        _navTitleLab.textAlignment = NSTextAlignmentCenter;
        _navTitleLab.font = [UIFont systemFontOfSize:18];
        _navTitleLab.textColor = kFontColor;
    }
    return _navTitleLab;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navLeftBtn addTarget:self action:@selector(navLeftPressed) forControlEvents:UIControlEventTouchUpInside];
        _navLeftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_navLeftBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _navLeftBtn;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navRightBtn addTarget:self action:@selector(navRightPressed:) forControlEvents:UIControlEventTouchUpInside];
        _navRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_navRightBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    }
    return _navRightBtn;
}

- (UILabel *)navSeperateLine {
    if (!_navSeperateLine) {
        _navSeperateLine = [[UILabel alloc] init];
        _navSeperateLine.backgroundColor = [UIColor clearColor];
    }
    return _navSeperateLine;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusAndNavigationBarHeitht, kScreen_Width, kScreen_Height - kStatusAndNavigationBarHeitht) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.delegate   = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


@end
