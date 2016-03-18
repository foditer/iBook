//
//  MessageViewController.h
//  单读
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) MessageModel *messageModel;
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIButton *backBtn;


@end
