//
//  RealWithUsViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/24.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "RealWithUsViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"

@interface RealWithUsViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NavView *navView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UITextField *textField;
@end

@implementation RealWithUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"";
    self.code = @"";
    [self statusBar];
    [self navView];
    
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:self.navView.maxY maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.scrollEnabled = NO;
    if(!self.isReal){
        self.tableView.tableFooterView = self.footerView;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(60), HeightXiShu(50))];
    title.text = @[@"姓      名",@"身份证号"][indexPath.row];
    title.font = HEITI(HeightXiShu(15));
    title.textColor = TitleColor;
    [cell.contentView addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+WidthXiShu(22), 0, kScreenWidth-(title.maxX+WidthXiShu(22))-WidthXiShu(30), HeightXiShu(50))];
    if(self.isReal){
        textField.placeholder = @[self.realName,self.certiNumber][indexPath.row];
    }else{
        textField.placeholder = @[@"请输入姓名",@"请输入您的身份证号码"][indexPath.row];
    }
    textField.enabled = !self.isReal;
    textField.font = HEITI(HeightXiShu(15));
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    textField.tag = indexPath.row;
    [textField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:textField];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:cutLine];
    
    if(indexPath.row == 0){
        cutLine.hidden = NO;
    }else{
        cutLine.hidden = YES;
    }
    return cell;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"身份信息确认";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height-HeightXiShu(100))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(33), kScreenWidth, HeightXiShu(20))];
        title.text = @"请确认身份信息，无误后将进行人脸识别";
        title.textColor = MessageColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.font = HEITI(HeightXiShu(14));
        [footerView addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WidthXiShu(12), HeightXiShu(33)+title.maxY, kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.titleLabel.font = HEITI(HeightXiShu(19));
        btn.backgroundColor = ButtonColor;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = HeightXiShu(5);
        [btn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)submitAction{
    [self.textField resignFirstResponder];
    if([self.name isEqualToString:@""]){
        [self addAlertView:@"姓名不能为空" block:nil];
        return;
    }
    
    if([self.code isEqualToString:@""]){
        [self addAlertView:@"身份证不能为空" block:nil];
        return;
    }
    
    if(![StringTool validateIDCardNumber:self.code]){
        [self addAlertView:@"身份证不正确" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"realname" forKey:@"type"];
    [dic setObject:self.name forKey:@"names"];
    [dic setObject:self.code forKey:@"certiNumber"];
    
    __block typeof(self)wSelf = self;
    [MyCenterApi realWithBlock:^(NSString *string, NSError *error) {
        if(!error){
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [wSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertControl addAction:cancelAction];
            [wSelf presentViewController:alertControl animated:YES completion:nil];
        }
    } dic:dic noNetWork:nil];
}

#pragma mark - textFiled delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.textField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 0){
        self.name = textField.text;
    }else{
        self.code = textField.text;
    }
}
@end
