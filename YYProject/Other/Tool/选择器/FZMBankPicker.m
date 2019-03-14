//
//  FZMBankPicker.m
//  BlockChainFinance
//
//  Created by 于优 on 2018/4/11.
//  Copyright © 2018年 fuzamei. All rights reserved.
//

#import "FZMBankPicker.h"
#import "FZMMacros.h"

@interface FZMBankPicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 银行 */
@property (nonatomic, strong) NSArray *banks;

/** 当前选中银行名字 */
@property (nonatomic, copy) NSString *currentBack;
/** 当前选中银行id */
@property (nonatomic, copy) NSString *currentId;

/** 主视图 */
@property (nonatomic, strong) UIView *wholeView;

/** PickerView */
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation FZMBankPicker

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr {
    self = [super initWithFrame:frame];
    if (self){
        
        self.userInteractionEnabled = YES;
        self.frame = frame;
        
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
    _wholeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 235, FZM_SCREEN_WIDTH, 235)];
    [self addSubview:_wholeView];
    
    // 头部按钮视图
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FZM_SCREEN_WIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [_wholeView addSubview:topView];
    
    // 防止点击事件触发
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [topView addGestureRecognizer:topTap];
    
    // 标题文字
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake(0, 0, 110, 22);
    titleLab.center = topView.center;
    titleLab.text = @"请选择银行";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLab];
    
    // 取消
    UIButton *canaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canaleBtn.frame = CGRectMake(10, 0, 50, 40);
    [canaleBtn setTitle:@"取消" forState:UIControlStateNormal];
    canaleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [canaleBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
    [topView addSubview:canaleBtn];
    
    canaleBtn.tag = 0;
    [canaleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // 确定
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(FZM_SCREEN_WIDTH-50-10, 0, 50, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setTitleColor:UIColorFromRGB(0x237ae4) forState:UIControlStateNormal];
    [topView addSubview:sureBtn];
    
    sureBtn.tag = 1;
    [sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // pickerView
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, FZM_SCREEN_WIDTH, 240-40)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_wholeView addSubview:_pickerView];
    
    [self shopView];
}

- (void)shopView {
    
    [UIView animateWithDuration:0.3 animations:^ {
        _wholeView.frame = CGRectMake(0, self.frame.size.height - 235, FZM_SCREEN_WIDTH, 235);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hiddenView {
    
    [UIView animateWithDuration:0.3 animations:^ {
        _wholeView.frame = CGRectMake(0, self.frame.size.height, FZM_SCREEN_WIDTH, 235);
        
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
    pickerLabel.textColor = UIColorFromRGB(0x237ae4);
    
    return [[_banks objectAtIndex:row] objectForKey:@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _currentBack = [[_banks objectAtIndex:row] objectForKey:@"name"];
    _currentId = [[_banks objectAtIndex:row] objectForKey:@"id"];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews) {
        
        if (singleLine.frame.size.height < 1) {
            
            singleLine.backgroundColor = UIColorFromRGB(0xe9e9e9);
        }
    }
    
    UILabel *pickerLabel = [[UILabel alloc] init];
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}


@end
