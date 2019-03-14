//
//  ViewController.m
//  AddressPicker
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "ViewController.h"
#import "OSAddressPickerView.h"

@interface ViewController ()
{
    UIButton *_btn;
    OSAddressPickerView *_pickerview;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 40);
    if ([defaults objectForKey:@"address"]) {
        [_btn setTitle:[defaults objectForKey:@"address"] forState:UIControlStateNormal];
    } else {
        [_btn setTitle:@"请选择地址" forState:UIControlStateNormal];
    }
    [_btn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnEvent
{
    _pickerview = [[OSAddressPickerView alloc] initWithFrame:CGRectZero Data:nil];
    [self.view addSubview:_pickerview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    __weak UIButton *temp = _btn;
    _pickerview.block = ^(NSString *province,NSString *city)
    {
        [temp setTitle:[NSString stringWithFormat:@"%@ %@",province,city] forState:UIControlStateNormal];
         [defaults setObject:[NSString stringWithFormat:@"%@ %@",province,city] forKey:@"address"];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
