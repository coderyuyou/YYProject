//
//  YYAddressPicker.h
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YYAddressPickerDelegate <NSObject>

@optional
/** 代理方法返回省市区*/
- (void)YYAddressPickerWithProvince:(YYAddressModel *)province city:(YYAddressCityModel *)city area:(YYAddressCountyModel *)area;
/** 取消代理方法*/
- (void)YYAddressPickerCancleAction;

@end

@interface YYAddressPicker : UIView

/** 省 */
@property (nonatomic, strong) YYAddressModel *province;
/** 市 */
@property (nonatomic, strong) YYAddressCityModel *city;
/** 区 */
@property (nonatomic, strong) YYAddressCountyModel *area;

@property (nonatomic, weak) id<YYAddressPickerDelegate> delegate;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;

@end

NS_ASSUME_NONNULL_END
