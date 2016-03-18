//
//  ResultTableView.m
//  单读
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ResultTableView.h"
#import "CommonCell.h"

static NSString *identifier = @"identify";

@implementation ResultTableView

- (void)awakeFromNib {
    self.dataArray = [NSMutableArray array];
    [self registerNib:[UINib nibWithNibName:@"CommonCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.dataSource = self;
}

- (void)setDataArray:(NSMutableArray<ArticleModel *> *)dataArray {
    if (dataArray != nil) {
        _dataArray = dataArray;
    }
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.article = _dataArray[indexPath.row];
    return cell;
}

@end
