//
//  CalendarViewCell.m
//  单读
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CalendarViewCell.h"

@implementation CalendarViewCell

- (void)awakeFromNib {
    
}

- (void)setCalendar:(MyCalendarModel *)calendar {
    NSURL *url = [NSURL URLWithString:calendar.thumbnail];
    [self.picView sd_setImageWithURL:url];
    NSString *time = calendar.title;
    NSString *month = [time substringWithRange:NSMakeRange(0, 2)];
    month = [NSString stringWithFormat:@"%d月",[month intValue]];
    NSString *day = [time substringWithRange:NSMakeRange(2, 2)];
    time = [NSString stringWithFormat:@"%@ , %@",month,day];
    self.timeLabel.text = time;
}

@end
