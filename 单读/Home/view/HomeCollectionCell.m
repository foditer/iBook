//
//  HomeCollectionCell.m
//  单读
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeCollectionCell.h"

static BOOL isPlay = NO;

@implementation HomeCollectionCell

- (void)awakeFromNib {
    
}

- (void)setArticle:(ArticleModel *)article {
    if (article) {
        _article = article;
        
        isPlay = NO;
        
        NSURL *postURL = [NSURL URLWithString:_article.thumbnail];
        [self.postView sd_setImageWithURL:postURL];
        self.tipLabel.text = [NSString stringWithFormat:@" %@",_article.category];
        [self setTipLabelAttribute];
        self.title.text = [self _clearLineBreak:article.title];
        self.lead.text = article.excerpt;
        [self setSpaceAttribute:self.title];
        [self setSpaceAttribute:self.lead];
        self.author.text = article.author;
        self.readCount.text = [NSString stringWithFormat:@"阅读数：%@",article.view];
        [self.commentBtn setTitle:article.comment forState:UIControlStateNormal];
        [self.likeBtn setTitle:article.good forState:UIControlStateNormal];
//        懒加载创建播放图标
        if (!_playImg) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            view.center = CGPointMake(kScreenWidth/2, kScreenHeight * 0.2);
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 30;
            view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
            _playImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            [view addSubview:_playImg];
            [_postView addSubview:view];
        }
//        根据文章的种类设置图片
        switch ([_article.model integerValue]) {
            case 1:
                _play.hidden = YES;
                _playImg.superview.hidden = YES;
                break;
            case 2:
                _play.hidden = NO;
                _playImg.superview.hidden = NO;
                _playImg.image = [UIImage imageNamed:@"视频"];

                break;
            case 3:
                _play.hidden = NO;
                _playImg.superview.hidden = NO;
                _playImg.image = [UIImage imageNamed:@"音频"];

                break;
                
            default:
                
                break;
        }
    }
}

//清除掉字符串结尾的换行符
- (NSString *)_clearLineBreak:(NSString *)string {
    NSString *subStrng = [string substringWithRange:NSMakeRange(string.length - 2, 2)];
    if ([subStrng isEqualToString:@"\r\n"]) {
        string = [string substringWithRange:NSMakeRange(0, string.length - 2)];
    }
    return string;
}

//设置tipLabel字体间距为5
- (void)setTipLabelAttribute {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self.tipLabel.text];
    [attrString addAttribute:NSKernAttributeName value:@5 range:NSMakeRange(0, attrString.length)];
    self.tipLabel.attributedText = attrString;
}

//设置传入label的段间距为12
- (void)setSpaceAttribute:(UILabel *)label {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:12];
    [style setAlignment:NSTextAlignmentCenter];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
    label.attributedText = attrString;
}


- (IBAction)play:(id)sender {
//    将播放图标隐藏
    _playImg.superview.hidden = YES;
//    如果不在播放，则播放
    if (!isPlay) {
//        设置视频播放的播放器
        if ([_article.model integerValue] == 2) {
            
            _playerVC = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:_article.video]];
            _playerVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.4);
        }
//        设置音频播放的播放器
        else {
            _playerVC = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:_article.fm]];
            _playerVC.view.frame = CGRectMake(0, kScreenHeight * 0.4 - 40, kScreenWidth, 40);
        }
        [_playerVC prepareToPlay];
        [self insertSubview:_playerVC.view aboveSubview:_play];
        isPlay = YES;
    }
}

//当单元格移除屏幕时，播放取消，然后把播放器移除，并且等待下次播放
- (void)prepareForReuse {
    [_playerVC.view removeFromSuperview];
    [_playerVC stop];
    isPlay = NO;
}

@end
