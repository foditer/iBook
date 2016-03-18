//
//  MessageViewController.m
//  单读
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "CommonViewController.h"
#import "MessDetailViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _requestData];
    [self _createTitleView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.number) {
        case 1:
            [self _loadData];
            break;
            
        case 2:
            [self _requestData];
            break;
    }
    
    if (self.number == 1) {
        
        [self _loadData];
    }
    [self _createTableView];
}

- (void)_loadData
{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"]];
    self.dataArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        _messageModel = [[MessageModel alloc] init];
        _messageModel.titleLable = [dic objectForKey:@"title"];
        _messageModel.content = [dic objectForKey:@"content"];
        _messageModel.create_time = [dic objectForKey:@"create_time"];
        [_dataArr addObject:_messageModel];
    }
    [_tableView reloadData];
}

- (void)_requestData
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    //获取到点击到的数据源URL
    NSURL *url = [NSURL URLWithString:kRequestTable(self.number, 0, 0, 0)];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    NSURLSessionDataTask *task = [manger dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (responseObject) {
            _dataArray = [NSMutableArray array];

            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSArray *array = [responseObject objectForKey:@"datas"];
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    NSError *error = nil;
                    ArticleModel *article = [[ArticleModel alloc]initWithDictionary:dic error:&error];
                    [self.dataArray addObject:article];
                }
            }
        }
        
    }];
    [task resume];
}

- (void)_createTitleView {
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    NSLog(@"%ld",self.number);
    switch (self.number) {
        case 1:
            _titleView.title = @"消息";
            break;
        case 2:
            _titleView.title = @"评论";
            break;
        case 3:
            _titleView.title = @"收藏";
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

- (void)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}



#pragma mark - UITableView DataSourse deletage

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.number == 1) {
        return _dataArr.count;
    }
    if (self.number == 2) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.number == 1) {
        
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageID"];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] lastObject];
        }
        cell.messageModel = _dataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (self.number == 2) {
        
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentID"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCommentCell" owner:self options:nil]lastObject];
            return cell;
        }
    }
    
    else if (self.number == 3) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"暂无数据！";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.number == 1) {

//        [self.navigationController showViewController:webVC sender:nil];
//        ArticleModel *article = _dataArr[indexPath.row];
//        DetailViewController *detail = [[DetailViewController alloc] init];
//        detail.article = article;
        
//        [self.navigationController showViewController:detail sender:nil];
        
        MessDetailViewController *mesDetailVC = [[MessDetailViewController alloc] init];
        
        [self.navigationController showViewController:mesDetailVC sender:nil];
    }
    if (self.number == 2) {
        
        ArticleModel *article = _dataArray[indexPath.row];
        DetailViewController *detail = [[DetailViewController alloc]init];
        detail.article = article;
        
        [self.navigationController showViewController:detail sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
