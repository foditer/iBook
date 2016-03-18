//
//  AboutViewController.m
//  单读
//
//  Created by Macx on 16/1/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTitleView];
}

- (void)_createTitleView {
    
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    _titleView.title = @"关  于";
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

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
