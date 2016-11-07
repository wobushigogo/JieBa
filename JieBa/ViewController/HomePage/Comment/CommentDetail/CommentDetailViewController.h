//
//  CommentDetailViewController.h
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CommentDetailViewController : BaseTableViewController
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,strong)void(^delBlcok)();
@property(nonatomic,strong)void(^addCommentBlock)();
@end
