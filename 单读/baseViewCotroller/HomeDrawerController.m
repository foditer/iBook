//
//  HomeDrawerController.m
//  单读
//
//  Created by mac on 16/2/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeDrawerController.h"

@interface HomeDrawerController ()

@end

@implementation HomeDrawerController

- (void)awakeFromNib {
    self.maximumLeftDrawerWidth = kScreenWidth;
    self.maximumRightDrawerWidth = kScreenWidth;
//    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeCustom];
//    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeCustom];
    self.showsShadow = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.centerViewController == nil) {
        self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    }
    if (self.leftDrawerViewController == nil) {
        self.leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
    }
    if (self.rightDrawerViewController == nil) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"personal" bundle:nil];
        self.rightDrawerViewController = [storyBoard instantiateInitialViewController];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
