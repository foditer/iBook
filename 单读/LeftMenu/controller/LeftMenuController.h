//
//  LeftMenuController.h
//  单读
//
//  Created by mac on 16/2/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *escBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIStackView *buttonGroup;
- (IBAction)esc:(id)sender;
- (IBAction)setting:(id)sender;
- (IBAction)writing:(id)sender;
- (IBAction)audio:(id)sender;
- (IBAction)video:(id)sender;
- (IBAction)calendar:(id)sender;
- (IBAction)search:(id)sender;

@end
