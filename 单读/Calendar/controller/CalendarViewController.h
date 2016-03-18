//
//  CalendarViewController.h
//  单读
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewCell.h"
#import "MyCalendarModel.h"
#import "TitleView.h"

@interface CalendarViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *backBtn;
@property (nonatomic, strong)TitleView *titleView;

- (void)back:(UIButton *)sender;

@end
