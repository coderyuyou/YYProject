//
//  YYAddressPicker.m
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYAddressPicker.h"

@interface YYAddressPicker () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) NSArray<YYAddressModel *> *provinceArray;
@property (strong, nonatomic) NSArray<YYAddressCityModel *> *cityArray;
@property (strong, nonatomic) NSArray<YYAddressCountyModel *> *townArray;
@property (strong, nonatomic) UIPickerView *pickView;

@end

@implementation YYAddressPicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self getAddressInformation];
        [self setBaseView];
    }
    return self;
}

- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIColor *color = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    UIColor *btnColor = [UIColor colorWithRed:65.0/255 green:164.0/255 blue:249.0/255 alpha:1];
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 210, width, 30)];
    selectView.backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    [self addSubview:selectView];
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height - 180 , width,  180)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = color;
    [self addSubview:self.pickView];
    [self.pickView reloadAllComponents];
    [self updateAddress];
    
}

- (void)getAddressInformation {
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    //    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    //加载本地json数据
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSArray *citysArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *modelArray = [YYAddressModel mj_objectArrayWithKeyValuesArray:citysArr];
//    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[YYAddressModel class] json:citysArr];
    
    self.provinceArray = modelArray;
    self.cityArray = self.provinceArray[0].city;
    self.townArray = self.cityArray[0].conuty;
    
}


- (void)dateCancleAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(YYAddressPickerCancleAction)]) {
        [self.delegate YYAddressPickerCancleAction];
    }
}

- (void)dateEnsureAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(YYAddressPickerWithProvince:city:area:)]) {
        [self.delegate YYAddressPickerWithProvince:self.province city:self.city area:self.area];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row].areaName;
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row].areaName;
    } else {
        return [self.townArray objectAtIndex:row].areaName;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        if (self.provinceArray.count > 0) {
            self.cityArray = [self.provinceArray objectAtIndex:row].city;
        } else {
            self.cityArray = @[];
        }
        if (self.cityArray.count > 0) {
            self.townArray = [self.cityArray objectAtIndex:0].conuty;
        } else {
            self.townArray = @[];
        }
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 1) {
        
        self.townArray = self.cityArray[row].conuty;
        
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 2) {
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    [self updateAddress];
}

- (void)updateAddress {
    self.province = [self.provinceArray objectAtIndex:[self.pickView selectedRowInComponent:0]];
    self.city = [self.cityArray objectAtIndex:[self.pickView selectedRowInComponent:1]];
    self.area = [self.townArray objectAtIndex:[self.pickView selectedRowInComponent:2]];
}


@end
