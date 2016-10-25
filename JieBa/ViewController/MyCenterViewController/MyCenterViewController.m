//
//  MyCenterViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterHead.h"
#import "MyCenterApi.h"
#import "UserInfoModel.h"
#import "CenterViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "OrderViewController.h"
#import "MoreViewController.h"
#import "RealNameViewController.h"
#import "RealWithUsViewController.h"
#import "RechargeViewController.h"

@interface MyCenterViewController ()<MyCenterHeadDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)MyCenterHead *headView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIImageView *QRImageView;
@property(nonatomic,strong)UserInfoModel *userInfoModel;
-(UIView *)cellViewWithMainImg:(NSString *)mainImgName mainText:(NSString *)mainText subText:(NSString *)subText buttonName1:(NSString *)buttonName1 buttonName2:(NSString *)buttonName2 selector:(SEL)selector selector1:(SEL)selector1 selector2:(SEL)selector2 needMainBtn:(BOOL)needMainBtn stingOrImage:(BOOL)stingOrImage;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:0 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserName:) name:@"changeUserName" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeUserName" object:nil];
}

#pragma mark - tableView delegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1 || section == 2){
        return 1;
    }else if (section == 3){
        return 4;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        return HeightXiShu(80);
    }
    return HeightXiShu(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 0;
    }
    return HeightXiShu(10);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        NSString *imgName = @[@"myCenter_ balance",@"myCenter_ order",@"myCenter_center"][indexPath.section];
        NSString *mainText = @[@"账户余额",@"我的订单",@"个人中心"][indexPath.section];
        NSString *mainSelector = @[@"balanceAction",@"orderAction",@"centerAction"][indexPath.section];
        NSString *buttonName1 = @[@"充值",[NSString stringWithFormat:@"待评价  %ld",(long)self.userInfoModel.assed_count],@"实名认证"][indexPath.section];
        NSString *buttonName2 = @[@"提现",@"已评价",@"绑定银行卡"][indexPath.section];
        NSString *selector1 = @[@"creditAction",@"evaluateAction",@"approveAction"][indexPath.section];
        NSString *selector2 = @[@"withdrawAction",@"evaluateEndAction",@"bindAction"][indexPath.section];
        
        BOOL isString = YES;
        if(indexPath.section == 0){
            isString = YES;
        }else{
            isString = NO;
        }
        UIView *view = [self cellViewWithMainImg:imgName mainText:mainText subText:[NSString stringWithFormat:@"%@元",self.userInfoModel.balance] buttonName1:buttonName1 buttonName2:buttonName2 selector:NSSelectorFromString(mainSelector) selector1:NSSelectorFromString(selector1) selector2:NSSelectorFromString(selector2) needMainBtn:YES stingOrImage:isString];
        [cell.contentView addSubview:view];
    }else if (indexPath.section == 3){
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth, .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        if(indexPath.row == 3){
            cutLine.hidden = YES;
        }else{
            cutLine.hidden = NO;
        }
        [cell.contentView addSubview:cutLine];
        
        NSString *imgName = @[@"myCenter_invite",@"myCenter_active",@"myCenter_service",@"myCenter_more"][indexPath.row];
        NSString *mainText = @[@"邀请记录",@"活动专区",@"在线客服",@"更多"][indexPath.row];
        NSString *detailText = @[@"",@"",@"随时为您服务哦",@""][indexPath.row];
        
        UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(10), WidthXiShu(19), HeightXiShu(19))];
        smallImageView.image = [GetImagePath getImagePath:imgName];
        [cell.contentView addSubview:smallImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(53), 0, WidthXiShu(150), HeightXiShu(40))];
        titleLabel.text = mainText;
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16)-WidthXiShu(5)-WidthXiShu(100), 0, WidthXiShu(100), HeightXiShu(40))];
        detailLabel.text = detailText;
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.font = HEITI(HeightXiShu(12));
        detailLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:detailLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16), HeightXiShu(13), WidthXiShu(8), HeightXiShu(13))];
        arrowImgView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [cell.contentView addSubview:arrowImgView];
    }else{
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(40))];
        titleLabel.text = @"客服电话：400 663 9066";
        titleLabel.textColor = NavColor;
        titleLabel.font = HEITI(HeightXiShu(14));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 3){
        if(indexPath.row == 0){
        
        }else if (indexPath.row == 1){
        
        }else if (indexPath.row == 2){
        
        }else{
            MoreViewController *view = [[MoreViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
    }else if (indexPath.row == 4){
        
    }
}

#pragma mark - 页面元素
-(MyCenterHead *)headView{
    if(!_headView){
        MyCenterHead *headView = [[MyCenterHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(210))];
        headView.delegate = self;
        _headView = headView;
    }
    return _headView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        footerView.backgroundColor = AllBackLightGratColor;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        titleLabel.text = @"服务时间：法定工作日 9:00-20:00";
        titleLabel.textColor = TitleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = HEITI(HeightXiShu(10));
        [footerView addSubview:titleLabel];
        _footerView = footerView;
    }
    return _footerView;
}

#pragma mark - 创建前3个view
-(UIView *)cellViewWithMainImg:(NSString *)mainImgName mainText:(NSString *)mainText subText:(NSString *)subText buttonName1:(NSString *)buttonName1 buttonName2:(NSString *)buttonName2 selector:(SEL)selector selector1:(SEL)selector1 selector2:(SEL)selector2 needMainBtn:(BOOL)needMainBtn stingOrImage:(BOOL)stingOrImage{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(80))];
    UIView *cutLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [view addSubview:cutLine];
    [cutLine setMaxX:view.width maxY:view.halfHeight];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(10), WidthXiShu(19), HeightXiShu(19))];
    imageView.image = [GetImagePath getImagePath:mainImgName];
    [view addSubview:imageView];
    
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(53), 0, WidthXiShu(150), HeightXiShu(40))];
    mainLabel.font = HEITI(HeightXiShu(14));
    mainLabel.text = mainText;
    mainLabel.textColor = TitleColor;
    [view addSubview:mainLabel];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(10)-WidthXiShu(100), 0, WidthXiShu(100), HeightXiShu(40))];
    subLabel.font = HEITI(HeightXiShu(14));
    subLabel.text = subText;
    subLabel.textColor = TitleColor;
    subLabel.hidden  = !stingOrImage;
    subLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:subLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16), HeightXiShu(13), WidthXiShu(8), HeightXiShu(13))];
    arrowImgView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
    arrowImgView.hidden  = stingOrImage;
    [view addSubview:arrowImgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth, HeightXiShu(40));
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:buttonName1 forState:UIControlStateNormal];
    [button1 setTitleColor:TitleColor forState:UIControlStateNormal];
    button1.titleLabel.font = HEITI(HeightXiShu(14));
    button1.frame = CGRectMake(0, HeightXiShu(40), kScreenWidth/2-1, HeightXiShu(40));
    [button1 addTarget:self action:selector1 forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:buttonName2 forState:UIControlStateNormal];
    [button2 setTitleColor:TitleColor forState:UIControlStateNormal];
    button2.titleLabel.font = HEITI(HeightXiShu(14));
    button2.frame = CGRectMake(kScreenWidth/2+1, HeightXiShu(40), kScreenWidth/2-1, HeightXiShu(40));
    [button2 addTarget:self action:selector2 forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UIImageView *cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2, HeightXiShu(40), .5, HeightXiShu(40))];
    cutLine2.backgroundColor = AllLightGrayColor;
    [view addSubview:cutLine2];
    return view;
}

-(UIImageView *)QRImageView{
    if(!_QRImageView){
        UIImageView *QRImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(293), HeightXiShu(433))];
        QRImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(QRImageLong:)];
        longPress.minimumPressDuration = 0.8; //定义按的时间
        [QRImageView addGestureRecognizer:longPress];
        _QRImageView = QRImageView;
    }
    return _QRImageView;
}

#pragma mark - selector
-(void)creditAction{
    NSLog(@"creditAction");
    RechargeViewController *view = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)withdrawAction{
    NSLog(@"withdrawAction");
}

-(void)evaluateAction{
    NSLog(@"evaluateAction");
}

-(void)evaluateEndAction{
    NSLog(@"evaluateEndAction");
}

-(void)approveAction{
    [self loadNameStatus];
}

-(void)bindAction{
    NSLog(@"bindAction");
}

-(void)QRImageLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    __block typeof(self)wSelf = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否把图片保存到相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf saveImageToPhotos:self.QRImageView.image];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:agreeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:agreeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)changeUserName:(NSNotification *)noti{
    [self loadUserInfo];
}

#pragma mark - head的delegate
-(void)changeHeadClick{
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

-(void)messageClick{

}

-(void)QRCoedeClick{
    [self.QRImageView sd_setImageWithURL:self.userInfoModel.card_name_url];
    
    [self lew_presentPopupView:self.QRImageView animation:[LewPopupViewAnimationFade new] dismissed:^{
        NSLog(@"动画结束");
    }];
}

-(void)signClick{

}

-(void)activeClick{

}

-(void)balanceAction{

}

-(void)orderAction{
    OrderViewController *view = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)centerAction{
    __block typeof(self)wSelf = self;
    CenterViewController *view = [[CenterViewController alloc] init];
    view.logoutBlock = ^(void){
        wSelf.tabBarController.selectedIndex = 0;
    };
    [self.navigationController pushViewController:view animated:YES];
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
    //    imageData = UIImageJPEGRepresentation([GetImagePath getImagePath:@"001"], .3);
    
    //NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    [self gotoAddImage:imageData image:image];
    //[self.headImgView setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 接口
-(void)gotoAddImage:(NSData *)imageData image:(UIImage *)image{
    [MyCenterApi updataHeadWithBlock:^(NSString *imageUrl, NSError *error) {
        if(!error){
        
        }
    } imgData:imageData noNetWork:nil];
}

-(void)loadUserInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"system" forKey:@"_cmd_"];
    [dic setObject:@"countDetail" forKey:@"type"];
    [MyCenterApi getUserInfoListWithBlock:^(UserInfoModel *model, NSError *error) {
        if(!error){
            self.userInfoModel = model;
            [self.headView setModel:self.userInfoModel];
            [self.tableView reloadData];
        }
    } dic:dic noNetWork:nil];
}

-(void)loadNameStatus{
    __block typeof(self)wSelf = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"member_info" forKey:@"type"];
    [MyCenterApi getUserInfoWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            if([dict[@"nameStatus"] integerValue] == 1){
                RealWithUsViewController *view = [[RealWithUsViewController alloc] init];
                view.isReal = YES;
                view.realName = dict[@"names"];
                view.certiNumber = dict[@"certiNumber"];
                [wSelf.navigationController pushViewController:view animated:YES];
            }else{
                UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否实名认证" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"马上认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    RealWithUsViewController *view = [[RealWithUsViewController alloc] init];
                    view.isReal = NO;
                    view.realName = dict[@"names"];
                    view.certiNumber = dict[@"certiNumber"];
                    [wSelf.navigationController pushViewController:view animated:YES];
                }];
                [alertControl addAction:cancelAction];
                [alertControl addAction:agreeAction];
                [wSelf presentViewController:alertControl animated:YES completion:nil];
            }
        }
    } dic:dic noNetWork:nil];
}
@end
