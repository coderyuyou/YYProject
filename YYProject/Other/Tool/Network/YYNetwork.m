//
//  YYNetwork.m
//  YYProject
//
//  Created by 于优 on 2018/12/4.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYNetwork.h"
#import "YYProgressHUD.h"

@interface YYNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static YYNetwork *_instance = nil;

@implementation YYNetwork

+ (instancetype)sharedNetwork {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
           _instance = [[YYNetwork alloc] init];
        }
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.manager = [AFHTTPSessionManager manager];
        // 请求参数序列化类型
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 响应结果序列化类型
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 接受内容类型
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        // timeout
        self.manager.requestSerializer.timeoutInterval = 30.0f;
        
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        // https相关
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:NO];
        [securityPolicy setAllowInvalidCertificates:YES];
        self.manager.securityPolicy = securityPolicy;
        
        //    if ([FZMUserInfoManager sharedManager].cookie) {
        //        [self.manager.requestSerializer setValue:[FZMUserInfoManager sharedManager].cookie forHTTPHeaderField:@"Cookie"];
        //    }
        
        // self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD",nil];
        //设备相关信息
        // NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleNameKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        
        // [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    return self;
}

- (void)requestWithPath:(NSString *)url method:(NSInteger)method parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [YYProgressHUD showPlainText:@"网络连接失败！" view:nil];
            return;
        }
    }];
    
    NSLog(@"--请求详情--\n请求头: %@\n请求URL: %@\n请求param: %@\n\n",self.manager.requestSerializer.HTTPRequestHeaders, url, parameters);
    
    switch (method) {
        case RequestTypeGet: {
            
            [self.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(task, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                    // NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                    // NSInteger statusCode = response.statusCode;
                }
            }];
        }
            break;
        case RequestTypePost: {
            
            [self.manager POST:url parameters:parameters progress:nil success:success failure:failure];
        }
            break;
        case RequestTypeDelete: {
            [self.manager DELETE:url parameters:parameters success:success failure:failure];
        }
            break;
        case RequestTypePut: {
            [self.manager PUT:url parameters:parameters success:success failure:false];
        }
            break;
    }
}

/**
 *   POST
 */
- (void)requestWithPost: (NSString *)urlString
             parameters: (NSDictionary *)parameters
           successBlock: (ResponseSuccess)successBlock
           failureBlock: (ResponseFail)failureBlock {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [YYProgressHUD showPlainText:@"网络连接失败！" view:nil];
            return;
        }
    }];
    
    NSAssert(urlString != nil, @"url不能为空");
    
    //    if ([FZMUserInfoManager sharedManager].cookie) {
    //        [self.manager.requestSerializer setValue:[FZMUserInfoManager sharedManager].cookie forHTTPHeaderField:@"Cookie"];
    //    }
    
    NSLog(@"--请求详情--\n请求头: %@\n请求URL: %@\n请求param: %@\n\n",self.manager.requestSerializer.HTTPRequestHeaders, urlString, parameters);
    
    [self.manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--返回详情-- \n请求URL: %@\n 请求结果: %@\n", urlString, responseObject);
        
        if (successBlock) {
            ResponseModel *model = [[ResponseModel alloc] initWithResponse:responseObject];
            successBlock(model);
        }
        
        if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
            
        }
        else if ([[responseObject objectForKey:@"code"] integerValue] == 201) {
  
            // 清除本地用户信息
           
        }
        else {
            if ([responseObject objectForKey:@"message"]) {
//                [MBProgressHUD wj_showPlainText:[responseObject objectForKey:@"message"] view:kWindow];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [MBProgressHUD wj_showError:@"网络超时，请稍后再试" toView:kWindow];
        if (failureBlock) {
            failureBlock(error);
            //            NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
            //            NSInteger statusCode = response.statusCode;
        }
    }];
    
}

/**
 *   GET
 */

- (void)requestWithGet: (NSString *)urlString
            parameters: (NSDictionary *)parameters
          successBlock: (ResponseSuccess)successBlock
          failureBlock: (ResponseFail)failureBlock {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD wj_showPlainText:@"网络连接失败！" view:kWindow];
            return;
        }
    }];
    
    NSAssert(urlString != nil, @"url不能为空");
    NSLog(@"--请求详情--\n请求头: %@\n请求URL: %@\n请求param: %@\n\n",self.manager.requestSerializer.HTTPRequestHeaders, urlString, parameters);
    
    [self.manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--返回详情-- \n请求URL: %@\n 请求结果: %@\n", urlString, responseObject);
        //        [MBProgressHUD wj_hideHUDForView:kWindow];
        if (successBlock) {
            ResponseModel *model = [[ResponseModel alloc] initWithResponse:responseObject];
            successBlock(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [MBProgressHUD wj_showError:@"网络超时，请稍后再试" toView:kWindow];
        //        [MBProgressHUD wj_hideHUDForView:kWindow];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/**
 *  向服务器上传单文件
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure{
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD wj_showPlainText:@"网络连接失败！" view:kWindow];
            return;
        }
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [MBProgressHUD wj_showActivityLoading:FZMLocalizedString(@"上传中...", nil) toView:kWindow];
        // 设置时间格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:fileData name:@"image" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [MBProgressHUD wj_showSuccess:@"" toView:kWindow];
//        [MBProgressHUD wj_hideHUDForView:kWindow];
        if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
            
            if (success) {
                ResponseModel *model = [[ResponseModel alloc] initWithResponse:responseObject];
                success(model);
            }
        }
        else if ([[responseObject objectForKey:@"code"] integerValue] == 201) {
            // 清楚本地用户信息
           
        }
        else {
//            [MBProgressHUD wj_showError:[responseObject objectForKey:@"message"] toView:kWindow];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD wj_showError:@"网络访问超时，请稍后再试" toView:kWindow];
//        [MBProgressHUD wj_hideHUDForView:kWindow];
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}

/**
 *  向服务器上传多文件
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
       Datas:(NSArray<NSData *> *)fileDatas
  FieldNames:(NSArray<NSString *> *)fieldNames
   FileNames:(NSArray *)fileNames
    MimeType:(NSString *)mimeType
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure{
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD wj_showPlainText:@"网络连接失败！"view:kWindow];
            return;
        }
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < fileNames.count; i ++) {
            [formData appendPartWithFileData:fileDatas[i] name:fieldNames[i] fileName:fileNames[i] mimeType:mimeType];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        //        if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
        
        //            if (success) {
        //                FZMResponseModel *model = [[FZMResponseModel alloc] initWithResponse:responseObject];
        //                success(model);
        //            }
        //        }
        //        else if ([[responseObject objectForKey:@"code"] integerValue] == 201) {
        //            // 清楚本地用户信息
        //            [[FZMUserInfoManager sharedManager] didLoginOut];
        //        }
        //        else {
        //            [MBProgressHUD wj_showError:[responseObject objectForKey:@"message"] toView:kWindow];
        //        }
        //
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD wj_showError:@"网络访问超时，请稍后再试" toView:kWindow];
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}

/**
 *  向服务器上传多组多文件
 *
 *  @param url         要上传的文件接口
 *  @param parameter   上传的参数
 *  @param fileDatas   上传的文件\数据的数组
 *  @param fieldNames  服务对应的字段
 *  @param success     成功执行，block的参数为服务器返回的内容
 *  @param failure     执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
       Datas:(NSArray<NSArray<NSData *> *> *)fileDatas
  FieldNames:(NSArray<NSArray<NSString *> *> *)fieldNames
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
//            [MBProgressHUD wj_showPlainText:@"网络连接失败！"view:kWindow];
            return;
        }
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 准备图片数据
        NSMutableArray *imgAry = [[NSMutableArray alloc] init];
        for (NSArray<NSData *> *array  in fileDatas) {
            for (NSData *data in array) {
                [imgAry addObject:data];
            }
        }
        // 准备服务器名称地址
        NSMutableArray *nameAry = [[NSMutableArray alloc] init];
        for (NSArray<NSString *> *array  in fieldNames) {
            for (NSString *name in array) {
                [nameAry addObject:name];
            }
        }
        
        //        NSAssert(imgAry.count != nameAry.count, @"数据源错误！！！检查代码！！！");
        for (NSInteger i = 0; i < imgAry.count; i ++) {
            // 设置时间戳
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:imgAry[i] name:nameAry[i] fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD wj_showError:@"网络访问超时，请稍后再试" toView:kWindow];
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
    
}

/**
 监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                if (result) result(StatusUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                if (result) result(StatusNotReachable);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (result) result(StatusReachableViaWWAN);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (result) result(StatusReachableViaWiFi);
                break;
        }
    }];
}


@end

@implementation ResponseModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (self = [super init]) {
        self.statusCode = [response[@"code"] integerValue];
        self.responseData = response[@"data"]&&![response[@"data"] isEqual:[NSNull null]]?response[@"data"]:nil;
        self.message = response[@"message"];
        self.success = [response[@"success"] boolValue];
        self.originalData = response;
    }
    return self;
}


@end
