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
 *  内网测试  172.16.102.51:1029
 *  外网测试  114.55.11.139:1047
 */
static NSString *const URL_TEST = @"http://114.55.11.139:1047/rent/api/";
static NSString *const URL_IUSSUE = @"";

#pragma mark - ***************  模块  ***************
/**  */
static NSString *const PUSH_ListUserMessage = @"";


#endif /* API_h */
