//
//  UserModel.h
//  单读
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , strong) NSString *name; //用户名
@property (nonatomic , strong) NSString *sex;  //性别
@property (nonatomic , strong) NSString *born; //生日
@property (nonatomic , strong) UIImage *Icon;

+ (instancetype)shareUser; 

@end
