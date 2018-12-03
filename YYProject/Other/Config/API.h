//
//  API.h
//  YYProject
//
//  Created by 于优 on 2018/11/30.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#ifndef API_h
#define API_h

#pragma mark - ***************  BASEURL  ***************

#define BASEURL(url) [NSString stringWithFormat:@"%@%@",URL_TEST,url]
/** baseURL
 *  内网测试
 *  外网测试
 */
static NSString *const URL_TEST = @"";
static NSString *const URL_IUSSUE = @"";

#pragma mark - ***************  模块  ***************
/**  */
static NSString *const USER_userInfo = @"";


#endif /* API_h */
