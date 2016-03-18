//
//  ResultTableView.h
//  单读
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ResultTableView : UITableView <UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray<ArticleModel *> *dataArray;

@end
