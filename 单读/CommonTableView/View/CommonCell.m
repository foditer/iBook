//
//  CommonCell.m
//  SingleReading
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 潘二杰. All rights reserved.
//

#import "CommonCell.h"
#import "UIImageView+WebCache.h"
@implementation CommonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.text = [self _clearLineBreak:self.article.title];
    _autherName.text = self.article.author;
    
    [self setSpaceAttribute:_titleLabel];
    
    NSString *str = self.article.thumbnail;
    NSURL *url = [NSURL URLWithString:str];
    [_Image sd_setImageWithURL:url];
    
}

- (NSString *)_clearLineBreak:(NSString *)string {
    NSString *subStrng = [string substringWithRange:NSMakeRange(string.length - 2, 2)];
    if ([subStrng isEqualToString:@"\r\n"]) {
        string = [string substringWithRange:NSMakeRange(0, string.length - 2)];
    }
    return string;
}

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
