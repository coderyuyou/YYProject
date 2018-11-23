//
//  FZMBaseViewController.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/23.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZMBaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

/** 导航栏 */
@property (nonatomic, strong) UIImageView *navView;
/** 导航左按钮（默认是返回图标） */
@property (nonatomic, strong) UIButton *navLeftBtn;
/** 导航右按钮（默认无内容）*/
@property (nonatomic, strong) UIButton *navRightBtn;
/** 导航栏标题 */
@property (nonatomic, strong) UILabel *navTitleLab;
/** 导航栏分割线 */
@property (nonatomic, strong) UILabel *navSeperateLine;

/** tableView */
@property (nonatomic, strong) UITableView *tableView;


/**
 *  导航左按钮事件（默认返回上一页）
 */
- (void)navLeftPressed;

/**
 *  导航右按钮事件（默认无内容）
 */

- (void)navRightPressed:(id)sender;

- (void)pop;

- (void)popToRootVc;

- (void)popToIndex:(NSInteger)index;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)(void))completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

/**
 *  下拉刷新
 */
- (void)loadHeaderRefresh:(UIScrollView *)scrollView completion:(void(^)(void))completion;

/**
 *  进入下拉刷新状态(只能在设置完之后使用)
 */
- (void)beginHeaderRefreshing:(UIScrollView *)scrollView;

/**
 *  上拉加载
 */
- (void)loadFooterRefresh:(UIScrollView *)scrollView completion:(void(^)(void))completion;

/**
 *  上拉加载 数据加载完毕
 */
- (void)endFooterRefreshWithNoMoreData:(UIScrollView *)scrollView;

/**
 *  上拉加载 恢复上拉加载
 */
- (void)resetFooterRefreshWithNoMoreData:(UIScrollView *)scrollView;

@end
