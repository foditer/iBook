//
//  DetailViewController.h
//  单读
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ArticleModel.h"
#import "MyCalendarModel.h"
#import "TitleView.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)ArticleModel *article;
@property (nonatomic, strong)MyCalendarModel *calendar;
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)MPMoviePlayerController *playerVC;
@property (nonatomic, strong)TitleView *titleView;
@property (nonatomic, strong)UIButton *backBtn;

@end
