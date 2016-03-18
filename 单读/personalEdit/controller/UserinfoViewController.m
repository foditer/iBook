//
//  UserinfoViewController.m
//  单读
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UserinfoViewController.h"
#import "UserModel.h"
#import "TableViewCellinfo.h"
#import "UserNameViewController.h"
#import "DateView.h"

@interface UserinfoViewController ()
{
    NSMutableArray *_array;
    
}

@end

@implementation UserinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建透明导航栏
    
    [self _createTitleView];
    
    //注册xib
    
    [_TableV registerNib:[UINib nibWithNibName:@"TableViewCellinfo" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.TableV.delegate = self;
    self.TableV.dataSource = self;
    
    _TableV.separatorStyle = NO;
    
    //解析Plist文件
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Personinfo" ofType:@"plist"];
   
    _array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    //设置头像为圆形
    
    _imageUser.layer.masksToBounds = YES;
    _imageUser.layer.borderWidth = 2.0;
    _imageUser.layer.cornerRadius = _imageUser.bounds.size.width*0.5;
    _imageUser.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userName.titleLabel.textColor = [UIColor whiteColor];
    _userName.tag = 102;
    
    //设置姓名居中的方法
    
    _userName.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //接收通知
    
    [[NSNotificationCenter
      defaultCenter] addObserver: self selector:@selector(callBack:)  name:@"back"object:nil];
    
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
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.imageUser setBackgroundImage:[UserModel shareUser].Icon forState:UIControlStateNormal];
    
    _imageUser.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateWithDuration:0.5 animations:^{
        _imageUser.transform = CGAffineTransformIdentity;
    }];
    
    //调用model给用户姓名赋值
    
    
    UserModel *user = [UserModel shareUser];

    [_userName setTitle:user.name forState:UIControlStateNormal];
    
    [self.TableV reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageUser.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callBack:(NSNotification *) back
{
    ((UIButton *)[self.view viewWithTag:102]).titleLabel.text = [back.object valueForKey:@"_name"];
    
    UserModel *user = [UserModel shareUser];

    user.name = [back.object valueForKey:@"_name"];
}

- (void)reload {
    
    [self.TableV reloadData];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.scrollEnabled = NO;
    
   TableViewCellinfo *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:1];
    
    NSDictionary *dic = _array[indexPath.row];
    
    NSString *str1 = [dic objectForKey:@"name"];
    
    UserModel *user = [UserModel shareUser];
    
    cell.label1.text = str1;
    
    //将Model的属性传入cell.label
    
    if (indexPath.row == 0) {
        
        cell.label2.text = user.name;
    }
    else if (indexPath.row == 1) {
        cell.label2.text = user.born;
    }
    else {
        cell.label2.text = user.sex;
    }


    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UserNameViewController *username = [[UserNameViewController alloc] init];
       
        [self.navigationController showViewController:username sender:nil];
    }
    
    if (indexPath.row == 1) {
        
        DateView *dateView = [[DateView alloc]initWithFrame:self.view.frame];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"reload" object:nil];
        
        [self.view addSubview:dateView];
        
        //优化用户的体验 将选择后的日期保存下来

        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
        formatter.dateFormat = @"yyyy年MM月dd日";
        
        NSDate *date = [formatter dateFromString:[UserModel shareUser].born];
        
        dateView.dateView.date = date;
        
        //dataView消失动画效果
       
        [UIView animateWithDuration:0.3 animations:^{
            dateView.save.transform = CGAffineTransformIdentity;
            dateView.dateView.transform = CGAffineTransformIdentity;
        }];
        
    }
    
    if (indexPath.row == 2) {
        
        UIAlertController *alertController = [[UIAlertController alloc] init];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [UserModel shareUser].sex = @"男";
            [self.TableV reloadData];
         }];
        
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            [UserModel shareUser].sex = @"女";
            [self.TableV reloadData];
        }];
     
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        [alertController addAction:archiveAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
   
}

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)changeIcon:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *change = [UIAlertAction actionWithTitle:@"修改头像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:change];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [UserModel shareUser].Icon = image;
    [picker dismissModalViewControllerAnimated:YES];
}

@end
