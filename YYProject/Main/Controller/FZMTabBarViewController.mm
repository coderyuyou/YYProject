//
//  FZMTabBarViewController.m
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/23.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMTabBarViewController.h"

@interface FZMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation FZMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [UITabBar appearance].translucent = NO;
//    [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    [self setUpAllChildVc];
    self.delegate = self;
}

#pragma mark - 初始化tabBar上的按钮

- (void)setUpAllChildVc {
    
    UIViewController *homeVc = [[UIViewController alloc] init];
    [self setupChildVcWithVc:homeVc Image:[UIImage imageNamed:@"tab_home_nor"] selectedImage:[UIImage imageNamed:@"tab_home_sel"] title:@"首页"];
    
    UIViewController *tradeVc = [[UIViewController alloc] init];
    [self setupChildVcWithVc:tradeVc Image:[UIImage imageNamed:@"tab_explore_nor"] selectedImage:[UIImage imageNamed:@"tab_explore_sel"] title:@"探索"];

    UIViewController *mineVc = [[UIViewController alloc] init];
    [self setupChildVcWithVc:mineVc Image:[UIImage imageNamed:@"tab_mine_nor"] selectedImage:[UIImage imageNamed:@"tab_mine_sel"] title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setupChildVcWithVc:(UIViewController *)Vc Image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
    Vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    
    NSDictionary *dictSelected = @{NSForegroundColorAttributeName:kFontColor, NSFontAttributeName:BOLDFONT_SIZE(11)};
    NSDictionary *dictNormal = @{NSForegroundColorAttributeName:kFontColor, NSFontAttributeName:FONT_SIZE(11)};
    
    [Vc.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
