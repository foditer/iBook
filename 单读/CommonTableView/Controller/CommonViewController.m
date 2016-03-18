//
//  CommonViewController.m
//  SingleReading
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 潘二杰. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonCell.h"
#import "AFHTTPSessionManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "UIImageView+WebCache.h"


@interface CommonViewController ()
{
    MPMoviePlayerController *_mpPlayer;
}
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self _createTitleView];
    
    [self _requestData];
    [self _createTableView];
    
    self.dataArray = [NSMutableArray array];
    
}

- (void)_createTitleView {
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    switch (self.number) {
        case 1:
            _titleView.title = @"文字";
            break;
        case 2:
            _titleView.title = @"视频";
            break;
        case 3:
            _titleView.title = @"声音";
            break;
    }
    [self.view addSubview:_titleView];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
}

//数据请求
- (void)_requestData {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    //获取到点击到的数据源URL
    NSURL *url = [NSURL URLWithString:kRequestTable(self.number, 0, 0, 0)];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [manger dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (responseObject) {
            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSArray *array = [responseObject objectForKey:@"datas"];
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    NSError *error = nil;
                    ArticleModel *article = [[ArticleModel alloc]initWithDictionary:dic error:&error];
                    [self.dataArray addObject:article];
                }
                [weakSelf.tableView reloadData];
            }
        }
        
    }];
    [task resume];
    
}

- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identify"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommonCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.article = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleModel *article = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.article = article;
    [self.navigationController showViewController:detail sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
