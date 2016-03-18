//
//  MessageModel.h
//  单读
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *titleLable;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSDictionary *array;

@end
