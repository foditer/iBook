





//
//  UserModel.m
//  单读
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 Macx. All rights reserved.
//
//  此model为单例

#import "UserModel.h"

static UserModel *userModel = nil;

@implementation UserModel

+ (instancetype)shareUser {
   
    //单例的设置
    
    if (userModel != nil) {
        return userModel;
    }
    else {
        userModel = [[UserModel alloc]init];
        return userModel;
    }
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [super allocWithZone:zone];
    });
    return userModel;
}

@end
