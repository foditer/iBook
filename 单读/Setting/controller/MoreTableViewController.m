



//
//  MoreTableViewController.m
//  单读
//
//  Created by Macx on 16/1/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MoreTableViewController.h"
#import "UIImageView+WebCache.h"
#import "AboutViewController.h"

@interface MoreTableViewController ()
{
    AboutViewController *_about;
    
}
@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
   
    [self countCatchSize];
    
    _about = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutView"];
    _about.view.backgroundColor = [UIColor whiteColor];
    _about.title = @"关 于";
    
    _Swi1.onTintColor = [UIColor brownColor];
    
    [self _createTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTitleView {
    
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.isTranslucent = NO;
    _titleView.backgroundColor = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    _titleView.title = @"设  置";
    
    UIImage *back = [UIImage imageNamed:@"back_gray"];
    back = [back imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:back forState:UIControlStateNormal];
    [_backBtn setTintColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleView setLeftBarButton:_backBtn];
}

-(void)countCatchSize
{
    NSUInteger fileSize = [[SDImageCache sharedImageCache]getSize];
   
    _ClearLable.text = [NSString stringWithFormat:@"%.2fM",fileSize / 1024.0 / 1024.0];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 2;
    }if (section == 1) {
        
        return 3;
    }else {
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache]clearDisk];
                
                [self countCatchSize];
                
            }];
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [self.navigationController showViewController:_about sender:nil];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        return self.titleView;
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        return 64;
    }
    else return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.013;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
