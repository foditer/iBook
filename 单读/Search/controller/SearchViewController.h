//
//  SearchViewController.h
//  单读
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"
#import "HotKeyModel.h"
#import "ResultTableView.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ResultTableView *tableView;
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (nonatomic, strong)UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIStackView *HotKeyList;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)NSMutableArray<HotKeyModel *> *hotkeys;
@property (nonatomic, strong)NSMutableArray<ArticleModel *> *dataArray;

@end
