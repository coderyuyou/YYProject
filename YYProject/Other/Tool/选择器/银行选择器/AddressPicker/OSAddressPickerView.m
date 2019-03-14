//
//  OSAddressPickerView.m
//  AddressPicker
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "OSAddressPickerView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface OSAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 银行 */
@property (nonatomic, strong) NSArray *banks;

/** 当前选中银行名字 */
@property (nonatomic, copy) NSString *currentBack;
/** 当前选中银行id */
@property (nonatomic, copy) NSString *currentId;

/** 主视图 */
@property (nonatomic, strong) UIView *wholeView;
/** 头部视图 */
@property (nonatomic, strong) UIView *topView;

/** PickerView */
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation OSAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr {
    self = [super initWithFrame:frame];
    if (self){
        
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        [self addGestureRecognizer:tap];
        
        [self createData];
        [self createView];
    }
    return self;
}

- (void)createData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bank.json" ofType:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    
    _banks = dict[@"banklist"];
    
    _currentBack = [[_banks objectAtIndex:0] objectForKey:@"name"];
    _currentId = [[_banks objectAtIndex:0] objectForKey:@"id"];

}

- (void)createView {
    
    // 弹出的整个视图
    _wholeView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 250)];
    [self addSubview:_wholeView];
    
    // 头部按钮视图
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    _topView.backgroundColor = [UIColor lightGrayColor];
    [_wholeView addSubview:_topView];
    
    // 防止点击事件触发
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_topView addGestureRecognizer:topTap];
    
    // 标题文字
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake((ScreenWidth-120)/2 , 9, 120, 22);
    titleLab.text = @"请选择所属地区";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    [_topView addSubview:titleLab];
    
    // 取消
    UIButton *canaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canaleBtn.frame = CGRectMake(10, 0, 50, 40);
    [canaleBtn setTitle:@"取消" forState:UIControlStateNormal];
    canaleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [canaleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_topView addSubview:canaleBtn];
    
    canaleBtn.tag = 0;
    [canaleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // 确定
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(ScreenWidth-50-10, 0, 50, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_topView addSubview:sureBtn];
    
    sureBtn.tag = 1;
    [sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // pickerView
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 240-40)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_wholeView addSubview:_pickerView];
    
    [self shopView];
}

- (void)shopView {
    
    [UIView animateWithDuration:0.3 animations:^ {
        _wholeView.frame = CGRectMake(0, ScreenHeight-250, ScreenWidth, 250);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hiddenView {
    
    [UIView animateWithDuration:0.3 animations:^ {
        _wholeView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - ****  action  ****

- (void)buttonEvent:(UIButton *)button {
    
    // 点击确定回调block
    if (button.tag == 1) {
        
        if (_block) {
            _block(_currentBack, _currentId);
        }
    }
    
    [self hiddenView];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44.0f;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_banks count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    UILabel *pickerLabel = (UILabel*)[pickerView viewForRow:row forComponent:component];
    pickerLabel.textColor = [UIColor blueColor];

    return [[_banks objectAtIndex:row] objectForKey:@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _currentBack = [[_banks objectAtIndex:row] objectForKey:@"name"];
    _currentId = [[_banks objectAtIndex:row] objectForKey:@"id"];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor redColor];
        }
    }
    
    UILabel *pickerLabel = [[UILabel alloc] init];
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

@end
