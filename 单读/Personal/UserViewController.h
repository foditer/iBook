//
//  UserViewController.h
//  单读
//
//  Created by Macx on 16/2/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *escBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

- (IBAction)esc:(id)sender;

- (IBAction)setting:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UIButton *imageUser;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UIStackView *buttonGroup;
- (IBAction)messageBtn:(UIButton *)sender;
- (IBAction)collectionBtn:(UIButton *)sender;
- (IBAction)commentBtn:(UIButton *)sender;

- (IBAction)Userinfo:(id)sender;


@end
