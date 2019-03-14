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

/** 省级 */
@property (nonatomic, strong) NSArray *provinces;
/** 市级 */
@property (nonatomic, strong) NSArray *citys;

/** 当前选中省级 */
@property (nonatomic, copy) NSString *currentProvince;
/** 当前选中市级 */
@property (nonatomic, copy) NSString *currentCity;

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
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *data = [[NSArray alloc]initWithContentsOfFile:plistPath];
    
    _provinces = data;
    
    // 第一个省分对应的全部市
    _citys = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
    // 第一个省份
    _currentProvince = [[_provinces objectAtIndex:0] objectForKey:@"state"];
    // 第一个省份对应的第一个市
    _currentCity = [[_citys objectAtIndex:0] objectForKey:@"city"];

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
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"address"]) {
//        [self refreshPickerView:[defaults objectForKey:@"address"]];
//    }
}

- (void)hiddenView {
    
    [UIView animateWithDuration:0.3 animations:^ {
        _wholeView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//- (void)refreshPickerView:(NSString *)address {
//
//    NSArray *addressArray = [address componentsSeparatedByString:@" "];
//    NSString *provinceStr = addressArray[0];
//    NSString *cityStr = addressArray[1];
//
//    int oneColumn = 0, twoColumn = 0;
//
//    // 省份
//    for (int i=0; i<_provinces.count; i++)
//    {
//        if ([provinceStr isEqualToString:[_provinces[i] objectForKey:@"state"]]) {
//            oneColumn = i;
//        }
//    }
//
//    // 用来记录是某个省下的所有市
//    NSArray *tempArray = [_provinces[oneColumn] objectForKey:@"cities"];
//    // 市
//    for  (int j=0; j<[tempArray count]; j++)
//    {
//        if ([cityStr isEqualToString:[tempArray[j] objectForKey:@"city"]])
//        {
//            twoColumn = j;
//            break;
//        }
//    }
//
//    [self pickerView:_pickerView didSelectRow:oneColumn inComponent:0];
//    [self pickerView:_pickerView didSelectRow:twoColumn inComponent:1];
//}

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
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    pickerLabel.textColor = [UIColor blueColor];

    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[_citys objectAtIndex:row] objectForKey:@"city"];
            break;

        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    [pickerView selectRow:row inComponent:component animated:YES];
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    if (!labelSelected) {
        labelSelected = [[UILabel alloc] init];
        [labelSelected setTextAlignment:NSTextAlignmentCenter];
        [labelSelected setFont:[UIFont systemFontOfSize:16]];
    }
    [labelSelected setTextColor:[UIColor blueColor]];
    
    switch (component) {
        case 0:
            
            _citys = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
            
            _currentProvince = [[_provinces objectAtIndex:row] objectForKey:@"state"];
            _currentCity = [[_citys objectAtIndex:0] objectForKey:@"city"];
            
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            break;
            
        default:
            break;
    }
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
    
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
        if (pickerLabel == [_pickerView viewForRow:row forComponent:component]) {
            pickerLabel.textColor = [UIColor blueColor];
        }
        else {
            pickerLabel.textColor = [UIColor blackColor];
        }
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

@end
