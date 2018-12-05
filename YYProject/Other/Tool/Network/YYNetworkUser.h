//
//  YYNetworkUser.h
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkUser : NSObject

+ (void)requestWithUserInfo:(NSDictionary *)parameters
           successBlock:(ResponseSuccess)successBlock
           failureBlock:(ResponseFail)failureBlock;

+ (void)requestWithCheckMobile:(NSDictionary *)parameters
                successBlock:(ResponseSuccess)successBlock
                failureBlock:(ResponseFail)failureBlock;

+ (void)requestWithUserIcon:(NSDictionary *)parameters
                      image:(UIImage *)image
                   progress:(void (^)(CGFloat *progress))progress
               successBlock:(ResponseSuccess)successBlock
               failureBlock:(ResponseFail)failureBlock;

+ (void)requestWithUserShow:(NSDictionary *)parameters
                     images:(NSArray<UIImage *> *)images
                   progress:(void (^)(CGFloat *progress))progress
               successBlock:(ResponseSuccess)successBlock
               failureBlock:(ResponseFail)failureBlock;

@end

NS_ASSUME_NONNULL_END
