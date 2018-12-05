//
//  YYNetworkUser.m
//  YYProject
//
//  Created by 于优 on 2018/12/5.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYNetworkUser.h"

@implementation YYNetworkUser

+ (void)requestWithUserInfo:(NSDictionary *)parameters successBlock:(ResponseSuccess)successBlock failureBlock:(ResponseFail)failureBlock {

    NSString *url = @"http://172.16.100.7:9901/api/Account/Asset";
    [[YYNetwork sharedNetwork] requestWithPath:url method:RequestTypeGet parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"--返回详情-- \n请求URL: %@\n 请求结果: %@\n", BASEURL(@""), responseObject);
        ResponseModel *model = [[ResponseModel alloc] initWithResponse:responseObject];
        if (successBlock) {
            successBlock(model);
        }
        
        if (model.statusCode == 201) {
            // 清除本地用户信息
            
        }
        else if (model.statusCode != 200){
            // 根据情况是否打印错误信息
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        // NSInteger statusCode = response.statusCode;
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)requestWithCheckMobile:(NSDictionary *)parameters
                  successBlock:(ResponseSuccess)successBlock
                  failureBlock:(ResponseFail)failureBlock {
    NSString *url = @"http://114.55.11.139:1047/rent/api/app/user/checkMobileAndPasswordExists";
    
    [[YYNetwork sharedNetwork] requestWithPath:url method:RequestTypePost parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"--返回详情-- \n请求URL: %@\n 请求结果: %@\n", BASEURL(@""), responseObject);
        ResponseModel *model = [[ResponseModel alloc] initWithResponse:responseObject];
        if (successBlock) {
            successBlock(model);
        }
        
        if (model.statusCode == 201) {
            // 清除本地用户信息
            
        }
        else if (model.statusCode != 200){
            // 根据情况是否打印错误信息
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        // NSInteger statusCode = response.statusCode;
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)requestWithUserIcon:(NSDictionary *)parameters image:(UIImage *)image progress:(void (^)(CGFloat * _Nonnull))progress successBlock:(ResponseSuccess)successBlock failureBlock:(ResponseFail)failureBlock {
    
    NSString *url = @"";
    // 图片压缩
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    // 设置文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    [[YYNetwork sharedNetwork]uploadFile:url parameter:parameters fileData:imageData name:@"image" fileName:fileName progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
   
}

+ (void)requestWithUserShow:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images progress:(void (^)(CGFloat * _Nonnull))progress successBlock:(ResponseSuccess)successBlock failureBlock:(ResponseFail)failureBlock {
    
    NSString *url = @"";
    
    NSMutableArray *fileDatas = [NSMutableArray new];
    NSMutableArray *names = [NSMutableArray new];
    NSMutableArray *fileNames = [NSMutableArray new];
    for (NSInteger i = 0; i < images.count; i ++) {
        // 图片压缩
        NSData *imageData = UIImageJPEGRepresentation(images[i], 0.3);
        [fileDatas addObject:imageData];
        // 设置服务器字段
        [names addObject:@"image"];
        // 设置文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [fileNames addObject:fileName];
        
    }
    
    [[YYNetwork sharedNetwork]uploadFileSet:url parameter:parameters fileDatas:fileDatas names:names fileNames:fileNames progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
