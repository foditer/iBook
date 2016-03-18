//
//  CalendarViewCell.h
//  单读
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCalendarModel.h"

@interface CalendarViewCell : UICollectionViewCell

@property (nonatomic, strong)MyCalendarModel *calendar;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end
