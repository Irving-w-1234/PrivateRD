//
//  UIControl+avoidDuplicate.m
//  baianlicai
//
//  Created by Liang Shen on 16/5/11.
//  Copyright © 2016年 Yosef Lin. All rights reserved.
//

#import "UIControl+avoidDuplicate.h"
#import <objc/runtime.h>

@implementation UIControl (avoidDuplicate)
@dynamic rd_acceptEventInterval;
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
- (NSTimeInterval )rd_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setRd_acceptEventInterval:(NSTimeInterval)rd_acceptEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(rd_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )rd_acceptEventTime{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setRd_acceptEventTime:(NSTimeInterval)rd_acceptEventTime{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(rd_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    //获取着两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(rd_sendAction:to:forEvent:));
    SEL mySEL = @selector(rd_sendAction:to:forEvent:);
    
    //添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    //如果方法已经存在了
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
        
    }
    
    //----------------以上主要是实现两个方法的互换,load是gcd的只shareinstance，果断保证执行一次
    
}

- (void)rd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.rd_acceptEventTime < self.rd_acceptEventInterval) {
        return;
    }
    
    if (self.rd_acceptEventInterval > 0) {
        self.rd_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self rd_sendAction:action to:target forEvent:event];
}

@end
