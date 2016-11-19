//
//  ViewController+SwilzzingMethod.m
//  SwilzzingApp
//
//  Created by kong on 16/11/19.
//  Copyright © 2016年 kong. All rights reserved.
//

#import "ViewController+SwilzzingMethod.h"
#import <objc/runtime.h>

@implementation ViewController (SwilzzingMethod)

+ (void)load
{
    [super load];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //实例
//        Class selfClass = [self class];
        
        //类
//        Class selfClass = object_getClass([self class]);
        
        Method methodOriginal = class_getInstanceMethod(self, @selector(viewDidLoad));
        
        Method methodNew = class_getInstanceMethod(self, @selector(swillzz_ViewDidLoad));
        
//        method_exchangeImplementations(methodOriginal, methodNew);
        
        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL addSucc = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(methodNew), method_getTypeEncoding(methodNew));
        if (addSucc) {
            //添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod([self class], @selector(swillzz_ViewDidLoad), method_getImplementation(methodNew), method_getTypeEncoding(methodNew));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(methodOriginal, methodNew);
        }
    });
}

- (void)swillzz_ViewDidLoad
{
    [self swillzz_ViewDidLoad];
    NSLog(@"haha");
}


@end
