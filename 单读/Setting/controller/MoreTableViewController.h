//
//  MoreTableViewController.h
//  单读
//
//  Created by Macx on 16/1/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"

@interface MoreTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *ClearLable;
@property (weak, nonatomic) IBOutlet UISwitch *Swi1;

@property (nonatomic, strong)TitleView *titleView;
@property (nonatomic, strong)UIButton *backBtn;

@end
