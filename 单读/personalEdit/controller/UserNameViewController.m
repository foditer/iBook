//
//  UserNameViewController.m
//  单读
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UserNameViewController.h"
#import "UserModel.h"

@interface UserNameViewController () {
    UITextView *text;
}

@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏
    [self _createTitleView];
    
    //让顶部不留空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:242/255.0 alpha:1];
    
    text = [[UITextView alloc] initWithFrame:CGRectMake(10, 84, kScreenWidth - 20, 200)];
    
    text.tag = 100;
    
    [self.view addSubview:text];
    
    self.view.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    
}

- (void)_createTitleView {
    
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = YES;
    [self.view addSubview:_titleView];
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setRightBarButton:save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
    [UserModel shareUser].name = text.text;
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
