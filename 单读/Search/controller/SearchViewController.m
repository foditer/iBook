//
//  SearchViewController.m
//  单读
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchViewController.h"
#import "HotKeyModel.h"

@interface SearchViewController () {
    NSURLSessionDataTask *searchTask;
}

@end

@implementation SearchViewController

- (void)awakeFromNib {
    self.hotkeys = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    [self requestHotKey];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.tableView.hidden = YES;
    _titleLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5 animations:^{
        _titleLabel.transform = CGAffineTransformIdentity;
    }];
    for (int i = 100; i < 106; i++) {
        UIButton *btn = [_HotKeyList viewWithTag:i];
        btn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }
    [UIView animateWithDuration:0.5 animations:^{
        for (int i = 100; i < 106; i++) {
            UIButton *btn = [_HotKeyList viewWithTag:i];
            btn.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTitleView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    [self _setHotKey];
}

- (void)requestHotKey {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    NSURL *url = [NSURL URLWithString:kRequestHotKeys];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseObject) {
            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSArray *array = [responseObject objectForKey:@"datas"];
                [self.hotkeys removeAllObjects];
                for (NSDictionary *dic in array) {
                    NSError *error = nil;
                    HotKeyModel *hotkey = [[HotKeyModel alloc]initWithDictionary:dic error:&error];
                    [self.hotkeys addObject:hotkey];
                }
            }
        }
        
    }];
    [task resume];
}

- (void)requestResult:(NSString *)key page:(NSInteger)page{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    AFHTTPRequestSerializer *requestSer = [AFHTTPRequestSerializer serializer];
    NSURLRequest *request = [requestSer requestWithMethod:@"POST" URLString:kRequestResult parameters:@{@"key":key,@"p":[NSNumber numberWithInteger:page]} error:nil];
    searchTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (responseObject) {
            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSDictionary *dictionary = [responseObject objectForKey:@"datas"];
                [self.dataArray removeAllObjects];
                NSArray *array = [dictionary objectForKey:@"lists"];
                if (array != nil) {
                    for (NSDictionary *dic in array) {
                        NSError *error = nil;
                        ArticleModel *article = [[ArticleModel alloc]initWithDictionary:dic error:&error];
                        [self.dataArray addObject:article];
                    }
                }
                _tableView.dataArray = self.dataArray;
            }
        }
        
    }];
    [searchTask resume];
}

- (void)_setHotKey {
    for (NSInteger i = 100; i < 106; i++) {
        UIButton *btn = [_HotKeyList viewWithTag:i];
        NSInteger j = i - 100;
        [btn setTitle:_hotkeys[j].name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([btn.titleLabel.text isEqualToString:@""]) {
            btn.hidden = YES;
        }
    }
}

- (void)_createTitleView {
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
}

- (void)buttonAction:(UIButton *)sender {
    NSString *key = sender.titleLabel.text;
    self.searchBar.text = key;
    [self searchBar:self.searchBar textDidChange:key];
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.y > 108) {
        [self.searchBar endEditing:YES];
    }
}

#pragma mark - searchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString:@""]) {
        self.tableView.hidden = YES;
        [self.tableView.dataArray removeAllObjects];
    }
    else {
        self.tableView.hidden = NO;
        [searchTask cancel];
        [self requestResult:searchText page:1];
    }
}

#pragma mark - tableView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleModel *article = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.article = article;
    [self.navigationController showViewController:detail sender:nil];
}

@end
