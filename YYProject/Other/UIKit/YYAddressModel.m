//
//  ERAddressModel.m
//  EasyRent
//
//  Created by 于优 on 2018/9/10.
//  Copyright © 2018年 EasyRent. All rights reserved.
//

#import "YYAddressModel.h"

@implementation YYAddressModel

//+ (NSDictionary *)objectClassInArray {
//    
//    return @{ @"city":[YYAddressCityModel class] };
//}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{ @"city":@"YYAddressCityModel" };
}

@end

@implementation YYAddressCityModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{ @"conuty":@"YYAddressCountyModel" };
}

@end

@implementation YYAddressCountyModel

@end
