//
//  ChangeInviteCodeViewController.m
//  JieBa
//
//  Created by 汪洋 on 16/10/21.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ChangeInviteCodeViewController.h"
#import "NavView.h"
#import "LoginApi.h"

#define placeholderFont HEITI(HeightXiShu(15))
#define titleMargin WidthXiShu(17)
#define titleWidth WidthXiShu(110)

@interface ChangeInviteCodeViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UIView *yzmView;
@property(nonatomic,strong)UIView *cameraView;
@property(nonatomic,strong)UIView *inviteCodeView;
@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *yzmTextFiled;
@property(nonatomic,strong)UITextField *inviteCodeTextFiled;
@property(nonatomic,strong)UIButton *yzmBtn;
@property(nonatomic,strong)UIButton *addCameraBtn;
@property(nonatomic,strong)UIButton *agreeBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NSData *imageData;
@property(nonatomic,assign)BOOL isAgree;
@end

@implementation ChangeInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAgree = YES;
    [self statusBar];
    [self navView];
    [self contentView];
    [self agreeBtn];
    [self titleLabel];
    [self submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = HeightXiShu(20);
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"修改邀请码";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(10)+self.navView.maxY, kScreenWidth, HeightXiShu(250))];
        contentView.backgroundColor = [UIColor whiteColor];
        
        [contentView addSubview:self.phoneView];
        [contentView addSubview:self.yzmView];
        [contentView addSubview:self.cameraView];
        [contentView addSubview:self.inviteCodeView];
        
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)phoneView{
    if(!_phoneView){
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"注册手机号";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [phoneView addSubview:title];
        
        UITextField *phoneTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, phoneView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        phoneTextFiled.placeholder = [LoginSqlite getdata:@"phone"];
        phoneTextFiled.font = placeholderFont;
        phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        phoneTextFiled.returnKeyType = UIReturnKeyDone;
        phoneTextFiled.delegate = self;
        phoneTextFiled.enabled = NO;
        [phoneTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [phoneView addSubview:phoneTextFiled];
        _phoneTextFiled = phoneTextFiled;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [phoneView addSubview:cutLine];
        
        _phoneView = phoneView;
    }
    return _phoneView;
}

-(UIView *)yzmView{
    if(!_yzmView){
        UIView *yzmView = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneView.maxY, kScreenWidth, HeightXiShu(50))];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"验 证 码";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [yzmView addSubview:title];
        
        UITextField *yzmTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, yzmView.width-(title.maxX+titleMargin)-WidthXiShu(100), HeightXiShu(50))];
        yzmTextFiled.placeholder = @"请输入验证码";
        yzmTextFiled.font = placeholderFont;
        yzmTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        yzmTextFiled.returnKeyType = UIReturnKeyDone;
        yzmTextFiled.delegate = self;
        [yzmTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [yzmView addSubview:yzmTextFiled];
        _yzmTextFiled = yzmTextFiled;
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(102), 0, 1, HeightXiShu(50))];
        line.backgroundColor = AllLightGrayColor;
        [yzmView addSubview:line];
        
        UIButton *yzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yzmBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(103), 0, WidthXiShu(103), HeightXiShu(50));
        [yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [yzmBtn setTitleColor:RGBCOLOR(99, 168, 233) forState:UIControlStateNormal];
        yzmBtn.titleLabel.font = placeholderFont;
        [yzmBtn addTarget:self action:@selector(yzmAction) forControlEvents:UIControlEventTouchUpInside];
        [yzmView addSubview:yzmBtn];
        _yzmBtn = yzmBtn;
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [yzmView addSubview:cutLine];
        
        _yzmView =yzmView;
    }
    return _yzmView;
}

-(UIView *)cameraView{
    if(!_cameraView){
        UIView *cameraView = [[UIView alloc] initWithFrame:CGRectMake(0, self.yzmView.maxY, kScreenWidth, HeightXiShu(100))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(25), titleWidth, HeightXiShu(50))];
        title.text = @"手持身份证照片";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [cameraView addSubview:title];
        
        UIButton *addCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addCameraBtn.adjustsImageWhenDisabled = NO;
        addCameraBtn.frame = CGRectMake(title.maxX+titleMargin, HeightXiShu(16), WidthXiShu(68), HeightXiShu(68));
        [addCameraBtn setImage:[GetImagePath getImagePath:@"myCenter_addCamera"] forState:UIControlStateNormal];
        [addCameraBtn addTarget:self action:@selector(addCameraACtion) forControlEvents:UIControlEventTouchUpInside];
        [cameraView addSubview:addCameraBtn];
        
        UIButton *addCameraBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        addCameraBtn2.frame = CGRectMake(addCameraBtn.maxX+WidthXiShu(15), HeightXiShu(25), WidthXiShu(80), HeightXiShu(50));
        [addCameraBtn2 setTitle:@"请添加图片" forState:UIControlStateNormal];
        [addCameraBtn2 setTitleColor:PlaceholderColor forState:UIControlStateNormal];
        addCameraBtn2.titleLabel.font = placeholderFont;
        [addCameraBtn2 addTarget:self action:@selector(addCameraACtion) forControlEvents:UIControlEventTouchUpInside];
        [cameraView addSubview:addCameraBtn2];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(99), kScreenWidth-WidthXiShu(10), .5)];
        cutLine.backgroundColor = AllLightGrayColor;
        [cameraView addSubview:cutLine];
        
        _cameraView = cameraView;
        _addCameraBtn = addCameraBtn;
    }
    return _cameraView;
}

-(UIView *)inviteCodeView{
    if(!_inviteCodeView){
        UIView *inviteCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.cameraView.maxY, kScreenWidth, HeightXiShu(50))];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, titleWidth, HeightXiShu(50))];
        title.text = @"邀请人手机号";
        title.font = placeholderFont;
        title.textColor = TitleColor;
        [inviteCodeView addSubview:title];
        
        UITextField *inviteCodeTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(title.maxX+titleMargin, 0, inviteCodeView.width-(title.maxX+titleMargin)-WidthXiShu(30), HeightXiShu(50))];
        inviteCodeTextFiled.placeholder = @"请输入邀请人手机号";
        inviteCodeTextFiled.font = placeholderFont;
        inviteCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        inviteCodeTextFiled.returnKeyType = UIReturnKeyDone;
        inviteCodeTextFiled.delegate = self;
        [inviteCodeTextFiled setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [inviteCodeView addSubview:inviteCodeTextFiled];
        _inviteCodeTextFiled = inviteCodeTextFiled;
        
        _inviteCodeView = inviteCodeView;
    }
    return _inviteCodeView;
}

-(UIButton *)agreeBtn{
    if(!_agreeBtn){
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(WidthXiShu(12), self.contentView.maxY+HeightXiShu(10), WidthXiShu(20), HeightXiShu(20));
        [agreeBtn setImage:[GetImagePath getImagePath:@"register_select"] forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:agreeBtn];
        
        _agreeBtn = agreeBtn;
    }
    return _agreeBtn;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.agreeBtn.maxX+WidthXiShu(5), self.contentView.maxY+HeightXiShu(10), WidthXiShu(200), HeightXiShu(20))];
        titleLabel.text = @"本人同意并已确认更换邀请人";
        titleLabel.font = HEITI(HeightXiShu(13));
        [self.view addSubview:titleLabel];
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(WidthXiShu(12), self.titleLabel.maxY+HeightXiShu(32), kScreenWidth-WidthXiShu(24), HeightXiShu(50));
        submitBtn.backgroundColor = ButtonColor;
        submitBtn.titleLabel.font = HEITI(HeightXiShu(19));
        [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = HeightXiShu(5);
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
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

-(void)addCameraACtion{
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

-(void)agreeAction{
    if(self.isAgree){
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"register_noSelect"] forState:UIControlStateNormal];
        self.isAgree = NO;
    }else{
        [self.agreeBtn setImage:[GetImagePath getImagePath:@"register_select"] forState:UIControlStateNormal];
        self.isAgree = YES;
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
    //    imageData = UIImageJPEGRepresentation([GetImagePath getImagePath:@"001"], .3);
    
    //NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    self.imageData = imageData;
    [self.addCameraBtn setImage:image forState:UIControlStateNormal];
    self.addCameraBtn.enabled = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 接口
-(void)yzmAction{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"recommendSms" forKey:@"type"];
    
    [LoginApi changeInviteYZMWithBlock:^(NSDictionary *dict, NSError *error) {
        if(!error){
            [self addAlertView:@"验证码已发送" block:nil];
        }
    } dic:dic noNetWork:nil];
}

-(void)submitAction{
    if(!self.isAgree){
        [self addAlertView:@"请同意条款" block:nil];
        return;
    }
    
    if([self.yzmTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"验证码不能为空" block:nil];
        return;
    }
    
    if([self.inviteCodeTextFiled.text isEqualToString:@""]){
        [self addAlertView:@"邀请人手机号不能为空" block:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"member_changeuserinfo" forKey:@"_cmd_"];
    [dic setObject:@"recommend" forKey:@"type"];
    [dic setObject:self.yzmTextFiled.text forKey:@"valid_code"];
    [dic setObject:self.inviteCodeTextFiled.text forKey:@"invite_mobile"];

    [LoginApi changeInviteWithBlock:^(NSString *string, NSError *error) {
        if(!error){
            [self addAlertView:string block:nil];
        }
    } dic:dic imageData:self.imageData noNetWork:nil];
}
@end
