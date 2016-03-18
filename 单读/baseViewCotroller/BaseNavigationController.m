//
//  BaseNavigationController.m
//  单读
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseNavigationController.h"



@interface BaseNavigationController () {
    UIButton *backBtn;
}

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    隐藏导航栏
    self.navigationBar.hidden = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count == 1) {
        backBtn.hidden = YES;
    }
    else {
        backBtn.hidden = NO;
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
