//
//  YYBaseViewController.h
//  YYProject
//
//  Created by 于优 on 2018/11/28.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBaseViewController : UIViewController

#pragma mark - UI相关
/** 自定义的Navigation来替换系统 */
@property (nonatomic, strong) YYNavigationBarView *navView;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;

#pragma mark - 控制器操作相关

/**
 *  当前控制器是否根控制器
 */
- (BOOL)isRootViewController;

/**
 *  导航左按钮事件（默认返回上一页）
 */
- (void)navLeftPressed;

/**
 *  导航右按钮事件（默认无内容）
 */
- (void)navRightPressed:(id)sender;

/**
 *  pop
 */
- (void)pop;

/**
 *  pop到根
 */
- (void)popToRootVc;

/**
 *  pop到指定栈
 */
- (void)popToIndex:(NSInteger)index;

/**
 *  pop到指定Vc
 */
- (void)popToVc:(UIViewController *)vc;

/**
 *  dismiss
 */
- (void)dismiss;

/**
 *  dismiss With block
 */
- (void)dismissWithCompletion:(void(^)(void))completion;

/**
 *  present
 */
- (void)presentVc:(UIViewController *)vc;

/**
 *  present With block
 */
- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

/**
 *  push
 */
- (void)pushVc:(UIViewController *)vc;

#pragma mark - 数据处理相关（下拉刷新，上拉加载）

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

NS_ASSUME_NONNULL_END
