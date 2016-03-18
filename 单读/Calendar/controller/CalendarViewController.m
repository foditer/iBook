//
//  CalendarViewController.m
//  单读
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTitleView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.dataArray = [NSMutableArray array];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self _requestCalendar];
}

- (void)_createTitleView {
    
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    _titleView.title = @"单向历";
    [self.view addSubview:_titleView];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - requestData

- (void)_requestCalendar {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURL *url = [NSURL URLWithString:kRequestCalendar];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseObject) {
            if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSArray *array = [responseObject objectForKey:@"datas"];
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    MyCalendarModel *model = [[MyCalendarModel alloc] initWithDictionary:dic error:nil];
                    [self.dataArray addObject:model];
                }
                [weakSelf.collectionView reloadData];
            }
        }
    }];
    [task resume];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.calendar = _dataArray[indexPath.item];
    return cell;
}

#pragma mark - collectionView delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, kScreenHeight - 64);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.calendar = self.dataArray[indexPath.item];
    [self.navigationController showViewController:detail sender:nil];
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
