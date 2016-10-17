//
//  BaseTableViewController.h
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "MJRefreshBackNormalFooter.h"
#import "MJRefreshGifHeader.h"

typedef enum {
    BaseTableViewRefreshHeader,
    BaseTableViewRefreshFooter,
    BaseTableViewRefreshFirstLoad
} BaseTableViewRefreshType;

@interface BaseTableViewController : BaseViewController <UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong, readonly) BaseTableView *tableView;
//是否需要在willDisplayCell的时候进行渐变动画
@property (nonatomic, assign) BOOL needCellAnimation;

//设置上拉刷新和下拉刷新,默认开启
- (void)setUpHeaderRefresh:(BOOL)headerRefresh footerRefresh:(BOOL)footerRefresh;

//下拉和上拉刷新触发后会调用
- (void)netWorkWithType:(BaseTableViewRefreshType)refreshType;
@end
