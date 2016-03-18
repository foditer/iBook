//
//  MessageTableViewCell.m
//  单读
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLable.text = self.messageModel.titleLable;
    _contentLable.text = self.messageModel.content;
    _create_time.text = self.messageModel.create_time;
    
    [self setSpaceAttribute:_titleLable];
    
}

//- (NSString *)_clearLineBreak:(NSString *)string {
//    NSString *subStrng = [string substringWithRange:NSMakeRange(string.length - 2, 2)];
//    if ([subStrng isEqualToString:@"\r\n"]) {
//        string = [string substringWithRange:NSMakeRange(0, string.length - 2)];
//    }
//    return string;
//}

- (void)setSpaceAttribute:(UILabel *)label {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:8];
    [style setAlignment:NSTextAlignmentLeft];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
    label.attributedText = attrString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
