//
//  FZMAddressPicker.m
//  BlockChainFinance
//
//  Created by 于优 on 2018/4/10.
//  Copyright © 2018年 fuzamei. All rights reserved.
//

#import "FZMAddressPicker.h"
#import "FZMMacros.h"

@interface FZMAddressPicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 省级 */
@property (nonatomic, strong) NSArray *provinces;
/** 市级 */
@property (nonatomic, strong) NSArray *citys;

/** 当前选中省级 */
@property (nonatomic, copy) NSString *currentProvince;
/** 当前选中市级 */
@property (nonatomic, copy) NSString *currentCity;

/** 父视图 */
@property (nonatomic, strong) UIView *wholeView;

/** PickerView */
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation FZMAddressPicker

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    
    _provinces = dict[@"citylist"];
    
    // 第一个省分对应的全部市
    _citys = [[_provinces objectAtIndex:0] objectForKey:@"city"];
    // 第一个省份
    _currentProvince = [[_provinces objectAtIndex:0] objectForKey:@"name"];
    // 第一个省份对应的第一个市
    _currentCity = [[_citys objectAtIndex:0] objectForKey:@"name"];
    
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
    titleLab.frame = CGRectMake(0, 0, 120, 22);
    titleLab.center = topView.center;
    titleLab.text = @"请选择所属地区";
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
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, FZM_SCREEN_WIDTH, 235-40)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_wholeView addSubview:_pickerView];
    
    [self shopView];
}

- (void)shopView {
    
    [UIView animateWithDuration:0.5 animations:^ {
        
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
            _block(_currentProvince, _currentCity);
        }
    }
    
    [self hiddenView];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44.0f;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [_citys count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    UILabel *pickerLabel = (UILabel*)[pickerView viewForRow:row forComponent:component];
    pickerLabel.textColor = UIColorFromRGB(0x237ae4);
    
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"name"];
            break;
            
        case 1:
            return [[_citys objectAtIndex:row] objectForKey:@"name"];
            break;
            
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            _citys = [[_provinces objectAtIndex:row] objectForKey:@"city"];
            _currentProvince = [[_provinces objectAtIndex:row] objectForKey:@"name"];
            _currentCity = [[_citys objectAtIndex:0] objectForKey:@"name"];
            
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            break;
            
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    //设置分割线的颜色
    for (UIView *singleLine in pickerView.subviews) {
        
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
