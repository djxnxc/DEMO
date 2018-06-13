//
//  ZendaiPasswordGestureViewController.m
//  ZendaiWallet
//
//  Created by ios on 14/12/10.
//  Copyright (c) 2014年 Zendai. All rights reserved.
//
#define PASSWORD_VIEW_SPACE 30

#import "PasswordGestureViewController.h"
//#import "DES3Util.h"
#import "AppDelegate.h"
#import "MainTabbarController.h"
//#import "WDCUserManage.h"
#import "WDCAccount.h"
#import "HZMAPImanager.h"
#import "LoginVC.h"
//extern WDCAccount *g_account;
@interface PasswordGestureViewController ()
{
    WDCAccount *_w;
}

@end

@implementation PasswordGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"设置手势密码";
    [self initPasswordGestureView];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }

    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.hidesBarsOnTap = YES;
    [self.navigationController setHidesBarsOnSwipe:YES];
    
     _w = [WDCUserManage getLastUserInfo];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _w = [WDCUserManage getLastUserInfo];
    
//    隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self positonSSFPasswordView];
}

-(void)setState:(SSFPasswordGestureViewState)state
{
    _state=state;
    //首次绘制手势密码
    if (state==SSFPasswordGestureViewStateWillFirstDraw) {
        UIImageView *image= (UIImageView *)[self.view viewWithTag:999];
        for (int i=101; i<110; i++) {
            
            UIImageView *imageView= (UIImageView *)[image viewWithTag:i];
            
            imageView.hidden=NO;
        }
        _boomView.hidden=YES;
        _labeltop.text = @"创建手势密码";
        _promptLabel.text = @"请绘制解锁图案";
        if (self.isfrom == 22) {
            _labeltop.text = @"修改手势密码";
        }
        if (self.isfrom == 23) {
            _labeltop.text = @"重设手势密码";
        }
    }
    //验证密码
    else if (state==SSFPasswordGestureViewStateCheck)
    {
        UIImageView *image= (UIImageView *)[self.view viewWithTag:999];
        for (int i=101; i<110; i++) {
            UIImageView *imageView= (UIImageView *)[image viewWithTag:i];
            imageView.hidden=NO;
        }
        
        _boomView.hidden=NO;
        _labeltop.text = @"手势密码登录";
        //设置手机号
        WDCAccount *w = [WDCUserManage getLastUserInfo];
        if (w.mobile && ![w.mobile isEqualToString:@""]) {
            [_promptLabel setText:[_w.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
        }else if (_w.email && ![_w.email isEqualToString:@""]){
            [_promptLabel setText:_w.email];
        }else{
            [_promptLabel setText:_w.userName];
        }
        
//        if (g_account.mobile && ![g_account.mobile isEqualToString:@""]) {
//            [_promptLabel setText:[g_account.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
//        }else if (g_account.email && ![g_account.email isEqualToString:@""]){
//            [_promptLabel setText:g_account.email];
//        }else{
//            [_promptLabel setText:g_account.userName];
//        }
    }


}

- (void)positonSSFPasswordView
{
    if (self.gestureContainView.frame.size.width >= self.gestureContainView.frame.size.height) {
        self.passwordGestureView.frame = CGRectMake(0, 0, self.gestureContainView.frame.size.height, self.gestureContainView.frame.size.height);
        self.passwordGestureView.center = CGPointMake(self.gestureContainView.frame.size.width/2, self.gestureContainView.frame.size.height/2+20);
    } else {
        self.passwordGestureView.frame = CGRectMake(0, 0, self.gestureContainView.frame.size.width, self.gestureContainView.frame.size.width);
        self.passwordGestureView.center = CGPointMake(self.gestureContainView.frame.size.width/2, self.gestureContainView.frame.size.height/2-20);
    }
    
}


-(void)initPasswordGestureView
{
    _passwordGestureView=[SSFPasswordGestureView instancePasswordView];
    _passwordGestureView.layer.cornerRadius=10 ;
    _passwordGestureView.delegate=self;
    
    _passwordGestureView.gesturePassword = _w.handPassword;
    _passwordGestureView.state=self.state;
    [self.gestureContainView addSubview:_passwordGestureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showHiddenWindow
{

    for (UIWindow *awindow in [UIApplication sharedApplication].windows) {
        if ([awindow isKindOfClass:[NSClassFromString(@"SSFlatShareActionSheet") class]]) {
            awindow.hidden=NO;
        }
        
        if ([awindow isKindOfClass:[NSClassFromString(@"_UIAlertOverlayWindow") class]]) {
            awindow.hidden=NO;
        }
    }

}
#pragma mark - 手势密码的代理

#pragma mark  保存手势密码，第一次绘制
- (void)passwordGestureViewFinishFirstTimePassword:(SSFPasswordGestureView *)passwordView andPasswordInProgress:(NSString *)password
{
    [self resetPromptView:password];
    _promptLabel.text=@"请再绘制一次";
    _promptLabel.textColor=[UIColor blackColor];
    JLog(@"第一次输入 password== %@",password);
    
}
#pragma mark  保存手势密码，第二次绘制
- (void)passwordGestureViewFinishSecondTimePassword:(SSFPasswordGestureView *)passwordView andPassword:(NSString *)password
{
    [self resetPromptView:password];
    JLog(@"第二次输入 password== %@",password);
    passwordView.gesturePassword=password;
    _w.setLock=YES;
    _w.handPassword=password;
    [Tool setBool:YES forKey:JIsSetSecretShoushi];
    //BOOL flag=[Tool boolForKey:JIsSetSecretShoushi];
    if (self.isfrom == 21) {//从注册而来，会跳入登录。
//        [self.navigationController popToRootViewControllerAnimated:YES];
        LoginVC *ll = [[LoginVC alloc] init];
        ll.isFrom = 99;
        UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        ll.navigationItem.backBarButtonItem = item;
        ll.navigationItem.hidesBackButton = YES;
        ll.navigationController.navigationBar.translucent = NO;
        [ll.navigationItem setHidesBackButton:YES];
        ll.hidesBottomBarWhenPushed = YES;
        UINavigationController *l = [[UINavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:l animated:YES completion:nil];
        
    }else if (self.isfrom == 22|self.isfrom == 23){//从登录之后，修改手势密码而来，会跳入首页。
        MainTabbarController *m = [[MainTabbarController alloc] init];
        [self presentViewController:m animated:YES completion:nil];
    }
    
    else{
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
    
    
}
#pragma mark  保存手势密码，判断两次绘制
- (void)passwordGestureViewFinishWrongPassword:(SSFPasswordGestureView *)passwordView andPasswordInProgress:(NSString *)password
{
    [self resetPromptView:password];
    _promptLabel.text=@"两次手势密码不一致,请重新绘制";
    _promptLabel.textColor=[UIColor redColor];
    [self lockAnimationForView:_promptLabel];
    JLog(@"两次不一样 password== %@",password);
    
    
}
#pragma mark  检查手势密码，OK
- (void)passwordGestureViewFinishCheckPassword:(SSFPasswordGestureView *)passwordView andPasswordInProgress:(NSString *)password
{
    [self resetPromptView:password];
    
    JLog(@"输入正确 password== %@",password);
    _promptLabel.text=[NSString stringWithFormat:@"手势密码输入正确"];
    //WDCUserManage *manager=[WDCUserManage sharedWDCUserManage];
    WDCAccount *a=[WDCUserManage getLastUserInfo];
    //WDCAccount* a=[WDCAccount sharedWDCAccount];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.pas,@"password"
                              ,a.userName,@"loginName",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = Login_NetWoring ;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 99;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
    /*MainTabbarController *m = [[MainTabbarController alloc ] init];
    self.view.window.rootViewController = m;
    [self dismissViewControllerAnimated:YES completion:nil];*/
    
    
 
}
#pragma mark  检查手势密码，不OK
- (void)passwordGestureViewCheckPasswordWrong:(SSFPasswordGestureView *)passwordView andInputCount:(NSInteger)count andPasswordInProgress:(NSString *)password
{
    [self resetPromptView:password];
    if (count>0) {
        _promptLabel.text=[NSString stringWithFormat:@"手势密码错误,还剩%ld次机会",(long)count];
    }
    else {
        _promptLabel.text = @"手势密码错误";
        ZendaiAlertView *alert=[[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"手势密码错误过多,已解除,请重新登录" leftButtonTitle:nil rightButtonTitle:@"确定"];
        __weak ZendaiAlertView *aler = alert;
        __weak PasswordGestureViewController *sel = self;
        alert.rightBlock=^()
        {
            [sel dismissViewControllerAnimated:NO completion:nil];
            [_w clear];
            [ WDCUserManage  removeLastUserInfo];
            
            LoginVC *ll = [[LoginVC alloc] init];
            ll.isFrom = 99;
            UINavigationController *lll  = [[UINavigationController alloc]initWithRootViewController:ll];
            [sel presentViewController:lll animated:YES completion:nil];
            [aler removeFromSuperviewi];

        };
        [alert show];
    }
    _promptLabel.textColor=[UIColor redColor];
    [self lockAnimationForView:_promptLabel];
    JLog(@"输入错误 password== %@",password);
    
}



-(void)resetPromptView:(NSString *)password
{
    
    UIImageView *image= (UIImageView *)[self.view viewWithTag:999];
    for (int i=101; i<110; i++) {
        
        UIImageView *imageView= (UIImageView *)[image viewWithTag:i];
        
        
        imageView.image=[UIImage imageNamed:@"xiaoyuan"];
    }
    
    for (int i=0; i<password.length; i++) {
        
        NSRange range=NSMakeRange(i, 1);
        NSString *str=[password substringWithRange:range];
        UIImageView *imageView= (UIImageView *)[image viewWithTag:100+[str intValue]];
        imageView.image=[UIImage imageNamed:@"xiaoyuan_xuan"];
    }
    
}

-(void)lockAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-5, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+5, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 交互

#pragma mark 忘记密码
- (IBAction)loseClicked {
    LoginVC *l = [[LoginVC alloc] init];
    l.isFrom = 88;
    //[self presentViewController:l animated:YES completion:nil];
    [self.navigationController pushViewController:l animated:YES];
    
}
#pragma mark 其他登录方式
- (IBAction)otherClicked {
    LoginVC *l = [[LoginVC alloc] init];
    l.isFrom = 88;
    //[self presentViewController:l animated:YES completion:nil];
    [self.navigationController pushViewController:l animated:YES];
    
}
-(void)transactionFailed:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        l.some =self;
        l.isFrom = 88;
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
    
}
-(void)transactionFinished:(HZMResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.requestId isEqualToString:Login_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            [Tool setObject:@"1" forKey:JIsLoginUser];
            WDCAccount* a=[WDCAccount sharedWDCAccount];
            [Tool setObject:a.userName forKey:LAST_USER_Phone];
            //[self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:[response.responseData objectForKey:@"message"]];
        }
    }
    
}
@end
