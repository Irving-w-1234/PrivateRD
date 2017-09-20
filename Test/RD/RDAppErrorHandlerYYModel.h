//
//  RDAppErrorHandlerYYModel.h
//  HuiBang
//
//  Created by 李帅良 on 2017/1/10.
//  Copyright © 2017年 Mr_zhaohy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDAppError.h"
/**
 错误状态值
 */
typedef NS_ENUM(NSInteger, RDP2PAppErrorTypeYY)
{
    /*
     返回数据不符合规范
     */
    RDP2PAppErrorTypeYYResponseModel = 0x0001,
    /*
     成功封装数据模型
     */
    RDP2PAppErrorTypeYYSuccess = 200,
    /*
     用户未登录
     */
    RDP2PAppErrorTypeYYNotLoggedIn = 0x8003,
    /*
     Token过期 - APP调用RefreshToken接口
     */
    RDP2PAppErrorTypeTokenTimeOut = 411,
    /*
     RefreshToken过期 - APP提示需要登录，跳转到登录页面
     */
    RDP2PAppErrorTypeRefreshTokenTimeOut = 412,
    /**
     Token不唯一 - APP提示被顶号，跳转到登录页面（token不存在）
     */
    RDP2PAppErrorTypeTokenNotUnique = 413,
    /**
     Token从其他设备登录，跳转到登录页面
     */
    RDP2PAppErrorTypeTokenNotOtherLogin = 410,
    /**
     账户被锁定 需要退出
     */
    RDP2PAppErrorTypeUserLock = 0x5001,
    /**
     充值功能被冻结
     */
    RDP2PAppErrorTypeUserFreezeRecharge = 0x5002,
    /**
     体现功能被冻结
     */
    RDP2PAppErrorTypeUserFreezeCash = 0x5003,
    /**
     投资功能被冻结
     */
    RDP2PAppErrorTypeUserFreezeInvest = 0x5004,
    /**
     变现能被冻结
     */
    RDP2PAppErrorTypeUserFreezeRealize = 0x5005,
    /**
     债权功能被冻结
     */
    RDP2PAppErrorTypeUserFreezeBond = 0x5006,
    /**
     借款功能被冻结
     */
    RDP2PAppErrorTypeUserFreezeLoan = 0x5007,
};

@interface RDAppErrorHandlerYYModel : NSObject<RDAppErrorDelegate>

+ (instancetype)sharedManager;

@end
