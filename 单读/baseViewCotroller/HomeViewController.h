//
//  HomeViewController.h
//  单读
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"

@interface HomeViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)TitleView *navigationView;
@property (nonatomic, strong)NSMutableArray *articles;

@end
