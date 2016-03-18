//
//  MyRefreshHeader.m
//  单读
//
//  Created by mac on 16/2/11.
//  Copyright © 2016年 mac. All rights reserved.
//
//自定义的下拉刷新界面

#import "MyRefreshHeader.h"

@implementation MyRefreshHeader {
    UIImageView *refreshView;
}

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    self.mj_h = 60;
    UIImage *image = [UIImage sd_animatedGIFNamed:@"refresh_2"];
    refreshView = [[UIImageView alloc]initWithImage:image];
    refreshView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor colorWithRed:24.0/255.0 green:24.0/255.0 blue:24.0/255.0 alpha:1];
    [self addSubview:refreshView];
}

- (void)placeSubviews {
    [super placeSubviews];
    refreshView.frame = CGRectMake(0, 10, kScreenWidth, 40);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:

            break;
        case MJRefreshStatePulling:
            
            break;
        case MJRefreshStateRefreshing:
            
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}

- (void)beginRefreshing {
    [super beginRefreshing];
    NSLog(@"开始刷新");
}

- (void)endRefreshing {
    [super endRefreshing];
    
    NSLog(@"刷新结束");
}

@end
