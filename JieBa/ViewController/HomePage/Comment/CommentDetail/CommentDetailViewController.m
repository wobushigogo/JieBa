//
//  CommentDetailViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/4.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "NavView.h"
#import "CarlifeApi.h"
#import "CarlifeModel.h"
#import "CommentHeadView.h"
#import "CarLifeCommentCell.h"
#import "CommentChatToolBar.h"

@interface CommentDetailViewController ()<CommentHeadViewDelegate,CommentChatToolBarDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)CarlifeModel *carlifeModel;
@property(nonatomic,strong)CommentHeadView *headView;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,strong)CommentChatToolBar *footerView;
@property(nonatomic)NSInteger startIndex;
@property(nonatomic)BOOL isReply;
@property(nonatomic)BOOL isShowBar;
@property(nonatomic)NSInteger replyIndex;
@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isReply = NO;
    self.isShowBar = NO;
    [self statusBar];
    [self navView];
    
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    [self loadInfo];
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty =  -rect.size.height;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0,ty-HeightXiShu(57));
        self.footerView.transform = CGAffineTransformMakeTranslation(0,ty);
    }];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
        self.footerView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightXiShu(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = self.modelArr[indexPath.row];
    return [CarLifeCommentCell carculateCellHeightWithString:model.content];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"CarLifeCommentCell";
    CarLifeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CarLifeCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CommentModel *model = self.modelArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = self.modelArr[indexPath.row];
    self.footerView.placeStr = [NSString stringWithFormat:@"@%@",model.name];
    self.isReply = YES;
    self.replyIndex = indexPath.row;
    
    [self footerView];
    self.isShowBar = YES;
    [UIView animateWithDuration:.2 animations:^{
        self.footerView.minY = kScreenHeight-HeightXiShu(57);
        self.tableView.transform = CGAffineTransformMakeTranslation(0,-HeightXiShu(57));
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(CommentHeadView *)headView{
    if(!_headView){
        CommentHeadView *headView = [[CommentHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        headView.delegate = self;
        _headView = headView;
        __block typeof(self)wSelf = self;
        headView.heightBlock = ^(CGFloat height){
            wSelf.headView.height = height;
            wSelf.tableView.tableHeaderView = wSelf.headView;
        };
    }
    return _headView;
}

-(UIView *)footerView{
    if(!_footerView){
        CommentChatToolBar *footerView = [[CommentChatToolBar alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, HeightXiShu(57))];
        footerView.delegate = self;
        [self.view addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commentClick:(NSString *)aId{
    self.isReply = NO;
    self.footerView.placeStr = @"评论";
    __block typeof(self)wSelf = self;
    if(self.isShowBar){
        wSelf.isShowBar = NO;
        [UIView animateWithDuration:.2 animations:^{
            wSelf.footerView.minY = kScreenHeight;
            self.tableView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [wSelf.footerView removeFromSuperview];
            wSelf.footerView = nil;
        }];
    }else{
        [self footerView];
        wSelf.isShowBar = YES;
        [UIView animateWithDuration:.2 animations:^{
            wSelf.footerView.minY = kScreenHeight-HeightXiShu(57);
            wSelf.tableView.transform = CGAffineTransformMakeTranslation(0,-HeightXiShu(57));
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)string{
    NSLog(@"====>%@",string);
    [self addNewComment:string];
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"detail" forKey:@"type"];
    [dic setObject:self.commentId forKey:@"id"];
    
    [CarlifeApi carlifeInfoWithBlock:^(CarlifeModel *model, NSError *error) {
        if(!error){
            self.carlifeModel = model;
            [self.headView setModel:model];
        }
    } dic:dic noNetWork:nil];
}

-(void)addNewComment:(NSString *)str{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"add_eval" forKey:@"type"];
    [dic setObject:self.commentId forKey:@"id"];
    [dic setObject:str forKey:@"content"];
    if(!self.isReply){
        [dic setObject:@"0" forKey:@"to_memberid"];
    }else{
        CommentModel *model = self.modelArr[self.replyIndex];
        [dic setObject:model.from_memberid forKey:@"to_memberid"];
    }
    __block typeof(self)wSelf = self;
    [CarlifeApi addCommentWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            wSelf.isShowBar = NO;
            [UIView animateWithDuration:.2 animations:^{
                wSelf.footerView.minY = kScreenHeight;
                self.tableView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [wSelf.footerView removeFromSuperview];
                wSelf.footerView = nil;
            }];
            self.startIndex = 1;
            [self netWorkWithType:BaseTableViewRefreshHeader];
        }
    } dic:dic noNetWork:nil];
}

-(void)netWorkWithType:(BaseTableViewRefreshType)refreshType{
    BOOL isHeaderRefresh = (refreshType == BaseTableViewRefreshFirstLoad || refreshType == BaseTableViewRefreshHeader);
    NSInteger startIndex = isHeaderRefresh ? 1 : (self.startIndex + 1);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"evalList" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:startIndex] forKey:@"page"];
    [dic setObject:self.commentId forKey:@"assed_id"];
    [dic setObject:@"10" forKey:@"number"];
    
    [CarlifeApi commentListWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            isHeaderRefresh ? self.modelArr = array : [self.modelArr addObjectsFromArray:array];
            [self.tableView reloadData];
            if(array.count == 0){
                self.startIndex = startIndex -1;
            }else{
                self.startIndex = startIndex;
            }
        }
        isHeaderRefresh ? [self.tableView.mj_header endRefreshing] : [self.tableView.mj_footer endRefreshing];
    } dic:dic noNetWork:nil];
}
@end
