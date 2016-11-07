//
//  OrderCommentViewController.m
//  JieBa
//
//  Created by 汪洋 on 2016/11/7.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "OrderCommentViewController.h"
#import "NavView.h"
#import "MyCenterApi.h"
#import "CarlifeApi.h"

@interface OrderCommentViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *contractLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeLabel;
@property(nonatomic,strong)NSMutableArray *buttonArr;
@property(nonatomic,strong)NSMutableArray *imgDataArr;
@property(nonatomic)NSInteger selectIndex;
@end

@implementation OrderCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectIndex = 0;
    self.buttonArr = [[NSMutableArray alloc] init];
    self.imgDataArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    [self statusBar];
    [self navView];
    
    [self contentView];
    [self submitBtn];
    
    [self loadInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"我的订单";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setTitle:@"上海" forState:UIControlStateNormal];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.maxY, kScreenWidth, HeightXiShu(325))];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:contentView];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(90))];
        [contentView addSubview:topView];
        
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(15), WidthXiShu(61), HeightXiShu(61))];
        [smallImageView sd_setImageWithURL:self.imageUrl placeholderImage:nil];
        [topView addSubview:smallImageView];
        
        UILabel *contractLabel = [[UILabel alloc] initWithFrame:CGRectMake(smallImageView.maxX+WidthXiShu(20), HeightXiShu(15), WidthXiShu(150), HeightXiShu(20))];
        contractLabel.textColor = TitleColor;
        contractLabel.font = HEITI(HeightXiShu(15));
        [topView addSubview:contractLabel];
        
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(smallImageView.maxX+WidthXiShu(20), contractLabel.maxY+HeightXiShu(22), WidthXiShu(150), HeightXiShu(20))];
        moneyLabel.font = HEITI(HeightXiShu(15));
        moneyLabel.textColor = TitleColor;
        [topView addSubview:moneyLabel];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(12), HeightXiShu(90), kScreenWidth-WidthXiShu(12), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [contentView addSubview:cutLine];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(WidthXiShu(12),cutLine.maxY + HeightXiShu(7), kScreenWidth-WidthXiShu(24), HeightXiShu(128))];
        textView.delegate = self;
        textView.font = HEITI(HeightXiShu(14));
        textView.textColor = TitleColor;
        textView.returnKeyType = UIReturnKeyDone;
        [contentView addSubview:textView];
        
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(12), cutLine.maxY + HeightXiShu(14), kScreenWidth-WidthXiShu(24), HeightXiShu(20))];
        placeLabel.text = @"亲！评价一下吧，您的评价对其他客户很重要哦~";
        placeLabel.font = HEITI(HeightXiShu(14));
        placeLabel.textColor = MessageColor;
        [contentView addSubview:placeLabel];
        
        for(int i=0;i<3;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(WidthXiShu(12)+(WidthXiShu(90)*i), textView.maxY+HeightXiShu(14), WidthXiShu(79), HeightXiShu(79));
            btn.tag = i;
            [btn setImage:[GetImagePath getImagePath:@"myCenter_ camer"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(camerAction:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:btn];
            [self.buttonArr addObject:btn];
        }
        
        _contentView = contentView;
        _contractLabel = contractLabel;
        _moneyLabel = moneyLabel;
        _textView = textView;
        _placeLabel = placeLabel;
    }
    return _contentView;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn setTitle:@"发表评价" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
        
        _submitBtn = submitBtn;
    }
    return _submitBtn;
}

#pragma mark - 事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitAction{
    if([self.textView.text isEqualToString:@""]){
        [self addAlertView:@"请填写评论" block:nil];
        return;
    }
    
    [self addComment:self.textView.text];
}

-(void)camerAction:(UIButton *)button{
    [self.textView resignFirstResponder];
    self.selectIndex = button.tag;
    __block typeof(self)wSelf = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loaclAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf localPhoto];
    }];
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf takePhoto];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:loaclAction];
    [alertControl addAction:takeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

#pragma mark - textViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    self.placeLabel.alpha=!textView.text.length;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 选照片
//开始拍照
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //UIImageWriteToSavedPhotosAlbum(image, self,nil, nil);
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    [self.imgDataArr replaceObjectAtIndex:self.selectIndex withObject:imageData];
    UIButton *btn = self.buttonArr[self.selectIndex];
    [btn setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 接口
-(void)loadInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"order" forKey:@"_cmd_"];
    [dic setObject:@"is_self_order" forKey:@"type"];
    [dic setObject:self.orderId forKey:@"order_id"];
    
    __block typeof(self)wSelf = self;
    [MyCenterApi orderCommentInfoWithBlock:^(NSMutableDictionary *dict, NSError *error) {
        if(!error){
            wSelf.contractLabel.text = [NSString stringWithFormat:@"合同编号：%@",dict[@"applyCode"]];
            wSelf.moneyLabel.text = [NSString stringWithFormat:@"放款金额：%@",dict[@"backtotalmoney"]];
        }
    } dic:dic noNetWork:nil];
}

-(void)addComment:(NSString *)string{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"carlife" forKey:@"_cmd_"];
    [dic setObject:@"assedCommit" forKey:@"type"];
    [dic setObject:self.orderId forKey:@"order_id"];
    [dic setObject:string forKey:@"content"];
    [dic setObject:@"上海" forKey:@"map_url"];
    
    self.submitBtn.enabled = NO;
    [CarlifeApi assedCommitWithBlock:^(NSMutableArray *array, NSError *error) {
        if(!error){
            [self addAlertView:@"发表成功，等待审核" block:nil];
        }
        self.submitBtn.enabled = YES;
    } dic:dic imageDataArr:self.imgDataArr noNetWork:nil];
}
@end
