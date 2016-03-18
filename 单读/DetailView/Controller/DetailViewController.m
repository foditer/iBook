//
//  DetailViewController.m
//  单读
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImage+GIF.h"

@interface DetailViewController () {
    UIImageView *loading;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    设置加载圆点转圈动画
    loading = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    loading.center = self.view.center;
    UIImage *image = [UIImage sd_animatedGIFNamed:@"圆点转圈"];
    [loading setImage:image];
}

- (void)_createTitleView {
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:0];
    _titleView.isTranslucent = YES;
    [self.view addSubview:_titleView];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
}

- (void)setArticle:(ArticleModel *)article {
    if (article != nil) {
        _article = article;
        [self setLayout];
        [self _createTitleView];
    }
}

- (void)setCalendar:(MyCalendarModel *)calendar {
    if (calendar != nil) {
        _calendar = calendar;
        [self setLayout];
        [self _createTitleView];
    }
}

//设置布局
- (void)setLayout {
    NSInteger model;
//    根据model值判断文章类型
    if (_article != nil) {
        model = [_article.model integerValue];
    }
    else {
        model = [_calendar.model integerValue];
    }
    switch (model) {
        case 1:
            [self notNeedPlayLayout];
            
            break;
        case 2:
            [self needPlayLayout:[NSURL URLWithString:_article.video]];

            break;
        case 3:
            [self needPlayLayout:[NSURL URLWithString:_article.fm]];
            
            break;
        case 4:
            [self notNeedPlayLayout];
            
            break;

        default:
            break;
    }
}

//设置不需要播放器的布局
- (void)notNeedPlayLayout {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSString *urlStr;
//    判断是文字还是单向历
    if (_article != nil) {
        urlStr = [_article.html5 stringByAppendingString:@"?client=iOS"];
    }
    else {
        urlStr = [_calendar.html5 stringByAppendingString:@"?client=iOS"];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:_webView];
}

- (void)needPlayLayout:(NSURL *)url{
//    先设置好顶部的图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.4)];
    imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [imageView sd_setImageWithURL:[NSURL URLWithString:_article.thumbnail]];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    [UIView animateWithDuration:0.5 animations:^{
        imageView.transform = CGAffineTransformIdentity;
    }];
    _playerVC = [[MPMoviePlayerController alloc]initWithContentURL:url];
//    判断是视频还是音频，设置播放器的位置和大小
    if ([_article.model integerValue] == 2) {
        
        _playerVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.4);
    }
    else {
        _playerVC.view.frame = CGRectMake(0, kScreenHeight * 0.4 - 40, kScreenWidth, 40);
    }
    [_playerVC prepareToPlay];
//    把播放器覆盖到顶部图片上
    [imageView addSubview:_playerVC.view];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 0.4, kScreenWidth, kScreenHeight * 0.6)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    NSString *urlStr = [_article.html5 stringByAppendingString:@"?client=iOS"];
    NSURL *html5 = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:html5]];
}

- (void)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view addSubview:loading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [loading removeFromSuperview];
}

#pragma mark - ScrollView Delegate
//根据滑动的y轴偏移量调整导航栏的透明度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    offset_Y = offset_Y > 100 ? offset_Y - 100 : 0;
    CGFloat alpha = offset_Y / 200.0;
    self.titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:alpha];
}

@end
