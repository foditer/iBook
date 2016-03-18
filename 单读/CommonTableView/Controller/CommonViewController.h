//
//  CommonViewController.h
//  SingleReading
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 潘二杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"


@interface CommonViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIButton *backBtn;

@end
