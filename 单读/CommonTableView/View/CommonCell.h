//
//  CommonCell.h
//  SingleReading
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 潘二杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface CommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *autherName;

@property (nonatomic, strong) ArticleModel *article;

@end
