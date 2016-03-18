//
//  HomeCollectionCell.h
//  单读
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HomeCollectionCell : UICollectionViewCell

@property (nonatomic, strong)ArticleModel *article;

@property (weak, nonatomic) IBOutlet UIImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *lead;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UIButton *play;

@property (nonatomic, strong) UIImageView *playImg;
@property (nonatomic, strong)MPMoviePlayerController *playerVC;

- (IBAction)play:(id)sender;

@end
