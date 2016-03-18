//
//  UserViewController.m
//  单读
//
//  Created by Macx on 16/2/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UserViewController.h"
#import "MoreTableViewController.h"
#import "UserModel.h"
#import "MessageViewController.h"

@interface UserViewController ()
{
    NSMutableArray *_data;
    MessageViewController *messageVC;
    MessageViewController *commentVC;
    MessageViewController *collectionVC;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//   设置头像为圆形
    _imageUser.layer.masksToBounds = YES;
    _imageUser.layer.borderWidth = 2.0;
    _imageUser.layer.cornerRadius = _imageUser.bounds.size.width*0.5;
    _imageUser.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIImage *personImg = [UIImage imageNamed:@"logo_owspace"];
    
    personImg = [personImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [_logoImage setImage:personImg];
    
    [_logoImage setTintColor:[UIColor whiteColor]];
    
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

//准备好要跳转的视图
- (void)prepareViewController {
    
    messageVC = [[MessageViewController alloc] init];
    messageVC.number = 1;
    commentVC = [[MessageViewController alloc] init];
    commentVC.number = 2;
    collectionVC = [[MessageViewController alloc] init];
    collectionVC.number = 3;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.userName setTitle:[UserModel shareUser].name forState:UIControlStateNormal];
    [self.imageUser setBackgroundImage:[UserModel shareUser].Icon forState:UIControlStateNormal];
    [self prepareForAnimation];
    _imageUser.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.6 animations:^{
        _escBtn.transform = CGAffineTransformIdentity;
        _settingBtn.transform = CGAffineTransformIdentity;
        _imageUser.transform = CGAffineTransformIdentity;
    }];
    for (int i = 100; i < 103; i++) {
        CGFloat duration = (i - 99) * 0.2;
        [UIView animateWithDuration:duration animations:^{
            UIButton *btn = [_buttonGroup viewWithTag:i];
            btn.transform = CGAffineTransformIdentity;
        }];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageUser.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }];
}

//动画前的准备
- (void)prepareForAnimation {
    _escBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _settingBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    for (int i = 100; i < 103; i++) {
        UIButton *btn = [_buttonGroup viewWithTag:i];
        btn.transform = CGAffineTransformMakeTranslation(kScreenWidth/4, 0);
    }
}

- (IBAction)messageBtn:(UIButton *)sender {
    [self.navigationController showViewController:messageVC sender:nil];
}

- (IBAction)collectionBtn:(UIButton *)sender {
    [self.navigationController showViewController:collectionVC sender:nil];
}

- (IBAction)commentBtn:(UIButton *)sender {
    [self.navigationController showViewController:commentVC sender:nil];
}


- (IBAction)Userinfo:(id)sender {
    
    [self.navigationController showViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"info"] sender:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)esc:(id)sender {
    if (self.mm_drawerController != nil) {
        
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
}

- (IBAction)setting:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"personal" bundle:nil];
    [self.navigationController showViewController:[story instantiateViewControllerWithIdentifier:@"Setting"] sender:nil];
    
}
@end
