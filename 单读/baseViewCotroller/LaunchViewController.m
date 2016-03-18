//
//  LaunchViewController.m
//  单读
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//
//启动时的动画界面

#import "LaunchViewController.h"

@interface LaunchViewController () {
    NSTimer *timer;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *device;
//    根据分辨率判断机型
    if (kScreenHeight == 736) {
        device = @"6p";
    }
    else if (kScreenHeight == 568) {
        device = @"5";
    }
    else if (kScreenHeight == 667) {
        device = @"6";
    }
    else {
        device = @"4";
    }
    [self launchBegin:device];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(launchFinish) userInfo:nil repeats:NO];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//根据机型选择前景图片
- (void)launchBegin:(NSString *)device {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ruban%@",device]];
    self.frontImage.image = image;
    [self _setBackground];
}

//从沙盒中加载背景图片的网址
- (void)_setBackground {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"images.plist"];
//    如果沙盒里存在，从沙盒加载，并且开始动画
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSString *imgUrl = array[arc4random_uniform((int)array.count)];
        self.backImage.alpha = 0;
        [self.backImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [UIView animateWithDuration:0.5 animations:^{
                _backImage.alpha = 1;
            } completion:^(BOOL finished) {
                [self animation];
            }];
        }];
    }
//    没有就从网络请求数据
    else {
        [self _requestData:path];
    }
}

//请求背景图片网址数据
- (void)_requestData:(NSString *)path {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    NSURL *url = [NSURL URLWithString:@"http://static.owspace.com/static/picture_list.txt"];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]) {
            NSArray *array = [responseObject objectForKey:@"images"];
//            把数据写入沙盒
            [array writeToFile:path atomically:YES];
            [weakSelf _setBackground];
        }
    }];
    [task resume];
}

- (void)animation {
    [timer invalidate];
    [UIView animateWithDuration:2.5 animations:^{
        self.backImage.transform = CGAffineTransformMakeTranslation(- 40, 0);
    } completion:^(BOOL finished) {
        [self launchFinish];
    }];
}

- (void)launchFinish{
    [UIView animateWithDuration:1 animations:^{
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        UIViewController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        self.view.window.rootViewController = main;
    }];
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
