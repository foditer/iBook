//
//  LeftMenuController.m
//  单读
//
//  Created by mac on 16/2/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LeftMenuController.h"
#import "CalendarViewController.h"
#import "CommonViewController.h"
#import "SearchViewController.h"

@interface LeftMenuController () {
    CommonViewController *writtingVC;
    CommonViewController *audioVC;
    CommonViewController *videoVC;
    CalendarViewController *calendar;
    SearchViewController *search;
}

@end

@implementation LeftMenuController

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *escImg = [UIImage imageNamed:@"Esc"];
    UIImage *settingImg = [UIImage imageNamed:@"Settings"];
    escImg = [escImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    settingImg = [settingImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_escBtn setImage:escImg forState:UIControlStateNormal];
    [_settingBtn setImage:settingImg forState:UIControlStateNormal];
    [_escBtn setTintColor:[UIColor whiteColor]];
    [_settingBtn setTintColor:[UIColor whiteColor]];
    
    [self prepareViewController];
}

- (void)prepareViewController {
    writtingVC = [[CommonViewController alloc]init];
    writtingVC.number = 1;
    audioVC = [[CommonViewController alloc]init];
    audioVC.number = 3;
    videoVC = [[CommonViewController alloc]init];
    videoVC.number = 2;
    calendar = [self.storyboard instantiateViewControllerWithIdentifier:@"Calendar"];
    search = [self.storyboard instantiateViewControllerWithIdentifier:@"Search"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self prepareForAnimation];
    [UIView animateWithDuration:0.6 animations:^{
        _escBtn.transform = CGAffineTransformIdentity;
        _settingBtn.transform = CGAffineTransformIdentity;
    }];
    for (int i = 100; i < 106; i++) {
        CGFloat duration = (i - 99) * 0.2;
        [UIView animateWithDuration:duration animations:^{
            UIButton *btn = [_buttonGroup viewWithTag:i];
            btn.transform = CGAffineTransformIdentity;
        }];
    }
}
//动画前的准备
- (void)prepareForAnimation {
    _escBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _settingBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    for (int i = 100; i < 106; i++) {
        UIButton *btn = [_buttonGroup viewWithTag:i];
        btn.transform = CGAffineTransformMakeTranslation(-kScreenWidth/4, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)esc:(id)sender {
    if (self.mm_drawerController != nil) {
        
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (IBAction)setting:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"personal" bundle:nil];
    [self.navigationController showViewController:[story instantiateViewControllerWithIdentifier:@"Setting"] sender:nil];
}

- (IBAction)writing:(id)sender {

    [self.navigationController showViewController:writtingVC sender:nil];
}

- (IBAction)audio:(id)sender {

    [self.navigationController showViewController:audioVC sender:nil];
}

- (IBAction)video:(id)sender {

    [self.navigationController showViewController:videoVC sender:nil];
}

- (IBAction)calendar:(id)sender {

    [self.navigationController showViewController:calendar sender:nil];
}

- (IBAction)search:(id)sender {
    
    [self.navigationController showViewController:search sender:nil];
}
@end
