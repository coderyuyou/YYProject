//
//  ERAddressModel.h
//  EasyRent
//
//  Created by 于优 on 2018/9/10.
//  Copyright © 2018年 EasyRent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYAddressCityModel, YYAddressCountyModel;

@interface YYAddressModel : NSObject

/** id */
@property (nonatomic, copy) NSString *areaCode;
/** name */
@property (nonatomic, copy) NSString *areaName;
/** 市 */
@property (nonatomic, strong) NSArray<YYAddressCityModel *> *city;

@end

@interface YYAddressCityModel : NSObject

/** id */
@property (nonatomic, copy) NSString *areaCode;
/** name */
@property (nonatomic, copy) NSString *areaName;
/** 区 */
@property (nonatomic, strong) NSArray<YYAddressCountyModel *> *conuty;

@end

@interface YYAddressCountyModel : NSObject

/** id */
@property (nonatomic, copy) NSString *areaCode;
/** name */
@property (nonatomic, copy) NSString *areaName;


@end
