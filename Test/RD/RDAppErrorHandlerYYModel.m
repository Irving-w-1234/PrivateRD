//
//  RDAppErrorHandlerYYModel.m
//  HuiBang
//
//  Created by 李帅良 on 2017/1/10.
//  Copyright © 2017年 Mr_zhaohy. All rights reserved.
//

#import "RDAppErrorHandlerYYModel.h"
#import "RDNetworkResult.h"
#import "RDMacro.h"
#import <YYModel/YYModel.h>
//#import "AppRequestMacro.h"




@implementation RDAppErrorHandlerYYModel
//instancetype ,不做具体类型检查
//利用dispatch_once 实现单例
+ (instancetype)sharedManager
{
    static RDAppErrorHandlerYYModel *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark RDAppErrorDelegate

- (void)beforeRequestURL:(NSString *__autoreleasing *)url headerParameter:(NSMutableDictionary *__autoreleasing *)headerParameter parameter:(NSMutableDictionary *__autoreleasing *)parameter
{
    *parameter = [[RdAppServiceAgent shareService].defaultConfig.commentArguments rdAppServiceBodyArgumentsAttach:*parameter];
    *headerParameter = [[RdAppServiceAgent shareService].defaultConfig.commentArguments rdAppServiceHeaderArgumentsAttach:*headerParameter];
    
}

- (void)endRequestDefaultFlag:(BOOL)defaultFlag
{
    if (defaultFlag) {
    }
}

- (RDAppError *)successRDAppErrorWithResponseObject:(id)responseObject
{
    RDNetworkResult *result = [RDNetworkResult yy_modelWithJSON:responseObject];
    if (result == nil || (result.code == 0 && result.msg == nil)) {
        return [[RDAppError alloc] initWithCode:RDP2PAppErrorTypeYYResponseModel errorMessage:@"返回数据格式有问题" responseData:responseObject];
    }
    return [[RDAppError alloc] initWithCode:result.code errorMessage:result.msg resData:result.data pageData:result.page];
    
}


- (RDAppError *)failRDAppErrorWithNetworkError:(NSError *)error
{
    return [[RDAppError alloc] initWithCode:error.code errorMessage:@"网络连接错误，请查看网络是否已连接!" responseData:nil];
}



- (id)response:(id)responseObject convertToModelClass:(__unsafe_unretained Class)ModelClass appError:(RDAppError *)appError
{
    if ([NSStringFromClass(ModelClass) isEqualToString:NSStringFromClass([NSDictionary class])]) {
        
        
        return appError.resData;
    }
    else
    {
        
//        return [ModelClass yy_modelWithDictionary:appError.errorData];;

        return [ModelClass yy_modelWithDictionary:appError.resData];
    }
}


- (BOOL)isResponseCanConvert:(RDAppError *)appError
{
    return appError.errorCode == RDP2PAppErrorTypeYYSuccess?YES:NO;
}


- (void)unifiedTreatmentAppError:(RDAppError *)appError
{
    //统一处理
    NSLog(@"code:%ld message:%@ data:%@",appError.errorCode, appError.errorMessage, appError.resData);
    if(appError.errorCode != RDP2PAppErrorTypeYYSuccess)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_AppErrorNotification object:nil userInfo:@{@"error":appError}];
    }
}

@end
