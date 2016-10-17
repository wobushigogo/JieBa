//
//  BaseTableView.h
//  JieBa
//
//  Created by 汪洋 on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableView;

@protocol BaseTableViewDelegate <UITableViewDelegate>

@optional

- (void)tableView:(BaseTableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(BaseTableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(BaseTableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(BaseTableView *)tableView changeFrame:(CGRect)frame;

@end

@interface BaseTableView : UITableView
@property (nonatomic, weak) id<BaseTableViewDelegate> delegate;
@end
