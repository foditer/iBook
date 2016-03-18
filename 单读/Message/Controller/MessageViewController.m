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

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _requestData];
    [self _createTitleView];
    [self _loadData];
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

//- (void)_requestData
//{
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
//    NSURL *url = [NSURL URLWithString:@"http://static.owspace.com/index.php?m=Home&c=Api&a=getMessage&uid=104068&page=1&client=android&version=1.1.0&time=1455937617&device_id=357566061490511&sign=92401f262b8b16eae05004e84adcdeab"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"get";
//    
//    __weak typeof (self)weakSelf = self;
//    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (responseObject) {
//            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
//                NSArray *array = [responseObject objectForKey:@"datas"];
//                [self.dataArr removeAllObjects];
//                for (NSDictionary *dic in array) {
//                    NSError *error = nil;
//                    ArticleModel *article = [[ArticleModel alloc] initWithDictionary:dic error:&error];
//                    [self.dataArr addObject:article];
//                    NSLog(@"%@",_dataArr);
//                }
//                [weakSelf.tableView reloadData];
//            }
//        }
//        
//    }];
//    [task resume];
//    
//}

- (void)_createTitleView {
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    switch (self.number) {
        case 1:
            _titleView.title = @"消息";
            break;
        case 2:
            _titleView.title = @"收藏";
            break;
        case 3:
            _titleView.title = @"评论";
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
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] lastObject];
    }
    cell.messageModel = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20)];
    NSURL *url = [NSURL URLWithString:@"http://static.owspace.com/wap/291667.html?client=android&device_id=357566061490511&version=1.1.0&show_video=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    UIViewController *webVC = [[UIViewController alloc] init];
    [webVC.view addSubview:webView];
    
    [self.navigationController showViewController:webVC sender:nil];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:_backBtn];
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
