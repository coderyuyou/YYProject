//
//  PagingViewController.m
//  YYProject
//
//  Created by 于优 on 2018/12/4.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "PagingViewController.h"
#import "SGPagingView.h"

@interface PagingViewController () <SGPageTitleViewDelegate, SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic, strong) UIViewController *leftVc;
@property (nonatomic, strong) UIViewController *rightVc;

@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}

- (void)createView {
    
    self.navView.title = @"PagingView";
    
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContentView];
}

#pragma mark - PageView

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

#pragma mark - setter & getter

- (SGPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
//        configure.showBottomSeparator = NO;
        configure.indicatorAdditionalWidth = 40;
        configure.titleColor = kFontColor_Gray;
        configure.titleSelectedColor = kFontColor;
        configure.indicatorColor = kFontColor_Red;
        configure.titleFont = FONT_SIZE(14);
        configure.titleSelectedFont = BOLDFONT_SIZE(16);
        
        _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kStatusAndNavigationBarHeitht, kScreen_Width, 40) delegate:self titleNames:@[@"左视图", @"右视图"] configure:configure];
    }
    return _pageTitleView;
}

- (SGPageContentView *)pageContentView {
    if (!_pageContentView) {
        NSArray *childArr = @[self.leftVc, self.rightVc];
        /// pageContentView
        CGFloat contentViewHeight = kScreen_Height - CGRectGetMaxY(self.pageTitleView.frame) - 10;
        
        _pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame) + 10, kScreen_Width, contentViewHeight) parentVC:self childVCs:childArr];
        _pageContentView.delegatePageContentView = self;
    }
    return _pageContentView;
}

- (UIViewController *)leftVc {
    if (!_leftVc) {
        _leftVc = [UIViewController new];
        _leftVc.view.backgroundColor = kColor;
    }
    return _leftVc;
}

- (UIViewController *)rightVc {
    if (!_rightVc) {
        _rightVc = [UIViewController new];
        _rightVc.view.backgroundColor = kColor;
    }
    return _rightVc;
}

@end
