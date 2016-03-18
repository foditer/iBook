//
//  UserinfoViewController.h
//  单读
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"

@interface UserinfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *TableV;
@property (weak, nonatomic) IBOutlet UIButton *imageUser; //用户头像
@property (weak, nonatomic) IBOutlet UIButton *userName;  //用户姓名

@property (nonatomic, strong)TitleView *titleView;
@property (nonatomic, strong)UIButton *backBtn;
- (IBAction)changeIcon:(id)sender;

@end
