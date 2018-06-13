
//
//  AccountTiXianViewController.m
//  MyVegetable
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountTiXianViewController.h"
#import "WDCAccount.h"
#import "PublicString.h"

@interface AccountTiXianViewController ()

@end

@implementation AccountTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isNomal=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden=YES;
    [self initUI];
    [self.nextBtn.layer setCornerRadius:18];
    [self.nextBtn.layer setMasksToBounds:YES];
    
    useMoney=0;
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary* dict=@{@"userId":@([a.userId intValue])};
    self.userMoney.text = [NSString stringWithFormat:@"      可提现金额(元):%@",@"0.00"];
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset=[[HZMRequest alloc]init];
    requset.requsetId=AccountTiXian_Jump;
    requset.requestParamDic=dict;
    requset.callBackDelegate=self;
    requset.tag=0x301;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    tableDefault=self.view.frame;
    isGetBound=NO;
    
}

-(void)initUI
{
    cellCard=[[InputCellTableViewCell alloc]initWithNib];
    cellCard.cardImage.image=[UIImage imageNamed:@"account_yinhangka.png"];
    cellCard.cardTitle.text=@"银行卡";
    cellCard.input.placeholder=@"请输入银行卡号";
    cellCard.input.tag=0x2001;
    cellCard.input.delegate=self;
    cellCard.rightArraw.hidden=YES;
    
    cellBank=[[InputCellTableViewCell alloc]initWithNib];
    cellBank.cardImage.image=[UIImage imageNamed:@"cash-bank.png"];
    cellBank.cardTitle.text=@"开户银行";
    cellBank.input.placeholder=@"请输入开户银行";
    cellBank.input.tag=0x2002;
    //cellBank.input.enabled=NO;
    cellBank.input.delegate=self;
    cellBank.rightArraw.hidden=YES;
    
    cellPro=[[InputCellTableViewCell alloc]initWithNib];
    cellPro.cardImage.image=[UIImage imageNamed:@"cash-provence.png"];
    cellPro.cardTitle.text=@"省份";
    cellPro.input.placeholder=@"请选择省份";
    cellPro.input.tag=0x2003;
    cellPro.input.enabled=NO;
    [cellPro.input setUserInteractionEnabled:NO];
    cellPro.contentView.userInteractionEnabled=YES;
   // cellPro.input.delegate=self;
    cellPro.rightArraw.hidden=NO;
    
    cellCity=[[InputCellTableViewCell alloc]initWithNib];
    cellCity.cardImage.image=[UIImage imageNamed:@"cash-city.png"];
    cellCity.cardTitle.text=@"城市";
    cellCity.input.placeholder=@"请选择城市";
    cellCity.input.tag=0x2004;
    cellCity.input.enabled=NO;
    //cellCity.input.delegate=self;
    [cellCity.input setUserInteractionEnabled:NO];
    cellCity.contentView.userInteractionEnabled=YES;
    cellCity.rightArraw.hidden=NO;
    
    cellOpen=[[InputCellTableViewCell alloc]initWithNib];
    cellOpen.cardImage.image=[UIImage imageNamed:@"cash-bank.png"];
    cellOpen.cardTitle.text=@"开户支行";
    cellOpen.input.placeholder=@"请输入开户银行支行";
    cellOpen.input.tag=0x2005;
    cellOpen.input.delegate=self;
    cellOpen.rightArraw.hidden=YES;
    
    cellMoney=[[InputCellTableViewCell alloc]initWithNib];
    cellMoney.cardImage.image=[UIImage imageNamed:@"account_jine.png"];
    cellMoney.cardTitle.text=@"金额";
    cellMoney.input.placeholder=@"请输入提现金额";
    cellMoney.input.tag=0x2006;
    cellMoney.input.keyboardType=UIKeyboardTypeNumbersAndPunctuation; //UIKeyboardTypeNumberPad;
    cellMoney.input.delegate=self;
    cellMoney.rightArraw.hidden=YES;
    UITapGestureRecognizer* ta=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cleanEdit)];
    //[self.view addGestureRecognizer:ta];

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.cardTable.delegate=self;
    self.cardTable.dataSource=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
-(void)cleanEdit
{
   // [self.view endEditing:YES];
    [cellCard.input resignFirstResponder];
    [cellBank.input resignFirstResponder];
    [cellOpen.input resignFirstResponder];
    [cellMoney.input resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isNomal) {
        return 6;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return cellCard;
        case 1:
            return cellBank;
        case 2:
        {
            if (isNomal) {
                return cellPro;
            }else{
                return cellMoney;
            }
        }
        case 3:
            return  cellCity;
        case 4:
            return cellOpen;
        case 5:
            return cellMoney;
            
        default:
            break;
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (isNomal) {
        if (indexPath.row==2) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary* dict=@{@"parentId":@(1)};
            
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset=[[HZMRequest alloc]init];
            requset.requsetId=ShengshiProvinceCity_NetWoring;
            requset.requestParamDic=dict;
            requset.callBackDelegate=self;
            requset.tag=0x301;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
        }
        if (indexPath.row==3) {
            if (provinceDict) {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSInteger proId=1;
                if (provinceDict) {
                    proId=[[provinceDict objectForKey:@"id"] integerValue];
                }
                NSDictionary* dict=@{@"parentId":[provinceDict objectForKey:@"id"]};
                
                [[HZMAPImanager shareMAPImanager]addDelegate:self];
                HZMRequest* requset=[[HZMRequest alloc]init];
                requset.requsetId=ShengshiProvinceCity_NetWoring;
                requset.requestParamDic=dict;
                requset.callBackDelegate=self;
                requset.tag=0x302;
                [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
            }else{
                UIAlertView* altert=[[UIAlertView alloc]initWithTitle:@"未选择省份" message:@"请选择省份，然后选择城市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [altert show];
            }
        }
    }

    [cellCard.input resignFirstResponder];
    [cellBank.input resignFirstResponder];
    [cellOpen.input resignFirstResponder];
    [cellMoney.input resignFirstResponder];
}
#pragma mark - HZMAPIManagerDelegate
-(void)transactionFinished:(HZMResponse *)response
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if ([response.requestId isEqualToString:ShengshiProvinceCity_NetWoring]) { //城市省份选择
        if (response.tag==0x301) {
            provinceArray=[response.responseData objectForKey:@"data"];
            NSMutableArray* str=[[NSMutableArray alloc]init];
            for (int i=0; i<provinceArray.count; i++ ) {
                [str addObject:[[provinceArray objectAtIndex:i] objectForKey:@"name"]];
            }
            SelectCityDialog* dialog=[[SelectCityDialog alloc]initWithNib];
            dialog.citys=str;
            dialog.selectDelegate=self;
            dialog.tag=0x1001;
            dialog.cityTitle.text=@"选择省份";
            [dialog show];
            
        }
        if (response.tag==0x302) {
            
            cityArray=[response.responseData objectForKey:@"data"];
            NSMutableArray* str=[[NSMutableArray alloc]init];
            for (int i=0; i<cityArray.count; i++ ) {
                [str addObject:[[cityArray objectAtIndex:i] objectForKey:@"name"]];
            }
            SelectCityDialog* dialog=[[SelectCityDialog alloc]initWithNib];
            dialog.citys=str;
            dialog.selectDelegate=self;
            dialog.tag=0x1002;
            dialog.cityTitle.text=@"选择城市";
            [dialog show];
        }
    }
    if ([response.requestId isEqualToString:AccountTiXian_Jump]) {  //提现跳转
        NSDictionary* data=[response.responseData objectForKey:@"data"];
        NSArray* cardList=[data objectForKey:@"cardList"];
        useMoney=[[data objectForKey:@"amount"] doubleValue];
        NSString *je=[data objectForKey:@"amount"];
        syMoney=[[data objectForKey:@"curCanExtractAmt"]doubleValue];
        self.userMoney.text=[NSString stringWithFormat:@"      可提现金额(元):%@",[NSString countNumAndChangeformat:je]];
        myCardInfo =[cardList firstObject];
        NSString* feestr=[data objectForKey:@"fee"];
        startGet=[[data objectForKey:@"extractMin"] doubleValue];
        self.handMoney.text=[NSString stringWithFormat:@"提现手续费：%@元",[NSString countNumAndChangeformat:feestr]];
        if (myCardInfo) {
            
            //NSLog(@"%@",myCardInfo);
            cellCard.input.text=[myCardInfo objectForKey:@"cardNo"];
            cellCard.input.enabled=NO;
            cellBank.input.text=[myCardInfo objectForKey:@"bankName"];
            cellBank.input.enabled=NO;
            if ([myCardInfo objectForKey:@"prcptcd"]) {
                //[self.moneyView setTranslatesAutoresizingMaskIntoConstraints:YES];
                prcptcd=[myCardInfo objectForKey:@"prcptcd"];
                isNomal=NO;
                [self.cardTable reloadData];
                braBank=[myCardInfo objectForKey:@"braBankName"];
                provinCode=[[myCardInfo objectForKey:@"provinceCode"]integerValue];
                cityCode=[[myCardInfo objectForKey:@"cityCode"]integerValue];
                isGetBound=YES;
            }
            
        }
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset1=[[HZMRequest alloc]init];
        requset1.requsetId=Check_Info;
        WDCAccount *a1 = [WDCUserManage getLastUserInfo];
        NSDictionary* dict1=@{@"type":@(1),@"userId":a1.userId};
        requset1.requestParamDic=dict1;
        requset1.callBackDelegate=self;
        requset1.tag=0x9001;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
        
    }
    if ([response.requestId isEqualToString:AccounBDcard_NetWoring]) {//银行查询
        if ([response.responseData objectForKey:@"data"]) {
            NSDictionary* data=[response.responseData objectForKey:@"data"];
            //NSDictionary* card=[data objectForKey:@"cardbin"];
            cellBank.input.text=[data objectForKey:@"bankName"];
            cellBank.input.enabled=NO;
        }
        if(![response.responseCodeOriginal isEqualToString:@"1"])
        {
            [self.view makeToast:response.responseMsg duration:2];
        }
        
    }
    if ([response.requestId isEqualToString:Bank_Card_Search]) {//大额行号
        NSArray* arr=[response.responseData objectForKey:@"data"];
        NSDictionary* data=[arr firstObject];
        prcptcd=[data objectForKey:@"prcptcd"];
        
        InputDialog* dialog=[[InputDialog alloc]initWithNib];
        dialog.tag=0x3001;
        dialog.title.text=@"输入交易密码";
        [dialog.inputMessage setSecureTextEntry:YES];
        dialog.inputDelegate=self;
        [dialog show];
        /*WDCAccount *a = [WDCUserManage getLastUserInfo];
        NSDictionary* dict=@{@"cardNum":cellCard.input.text,
                             @"amount":@([cellMoney.input.text integerValue]),
                             @"provinceCode":[provinceDict objectForKey:@"id"],
                             @"cityCode":[cityDict objectForKey:@"id"],
                             @"braBankName":cellOpen.input.text,
                             @"prcptcd":prcptcd,
                             @"userId":@([a.userId integerValue])};
        
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=AccounTiXian_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x302;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];*/
    }
    if ([response.requestId isEqualToString:AccounTiXian_NetWoring]) {//提现提交结束
        if ([[response.responseData objectForKey:@"code"] intValue]==1) {
            [self.view makeToast:@"提现成功！" duration:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:[response.responseData objectForKey:@"message"] duration:2];
        }
    }
    if ([response.requestId isEqualToString:Check_Info]) {//获得是否实名认证
        if(response.tag==0x9001)
        {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isTrue=YES;
            }else{
                isTrue=NO;
            }
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset1=[[HZMRequest alloc]init];
            requset1.requsetId=Check_Info;
            WDCAccount *a1 = [WDCUserManage getLastUserInfo];
            NSDictionary* dict1=@{@"type":@(2),@"userId":a1.userId};
            requset1.requestParamDic=dict1;
            requset1.callBackDelegate=self;
            requset1.tag=0x9002;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
            
        }
        if (response.tag==0x9002) {
            int result=[[response.responseData objectForKey:@"code"] intValue];
            if (result==1) {
                isPassword=YES;
            }else{
                isPassword=NO;
            }
        }
    }

    
    
    
}
-(void)transactionFailed:(HZMResponse *)response
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([response.responseCodeOriginal isEqualToString:@"-1"]|[response.responseCodeOriginal isEqualToString:@"-2"]|[response.responseCodeOriginal isEqualToString:@"-3"]|[response.responseCodeOriginal isEqualToString:@"-4"]|[response.responseCodeOriginal isEqualToString:@"-5"]|[response.responseCodeOriginal isEqualToString:@"-6"]|[response.responseCodeOriginal isEqualToString:@"-99"]) {
        [self.view makeToast:[response.responseData objectForKey:@"message"] duration:1.5 position:@"center"];
    }else
        [self.view makeToast:response.responseMsg duration:1.5 position:@"center"];
    
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.responseCodeOriginal isEqualToString:@"-99"]) {
        LoginVC *l = [[LoginVC alloc] init];
        [Tool setObject:[response.responseData objectForKey:@"message"] forKey:@"login_msg"];
        l.some =self;
        l.isFrom = 88;
        l.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:l animated:YES];
    }
    
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==0x2005) {
        CGRect f=self.view.frame;
        f.origin.y-=50;
        self.view.frame=f;
    }
    if (textField.tag==0x2006 && isNomal) {
        CGRect f=self.view.frame;
        f.origin.y-=100;
        self.view.frame=f;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    if (textField.tag==0x2006) {
        
    NSArray* thArr=[textField.text componentsSeparatedByString:@"."];
    if (thArr.count==2) {
        NSString* subS=[thArr objectAtIndex:1];
        if (subS) {
            if (subS.length>=2 && string.length>0) {
                return NO;
            }
        }
    }
        if ([string isEqualToString:@"."]&&textField.text.length==0) {
            textField.text=@"0";
        }

    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.view.frame=tableDefault;
    if (textField.tag==0x2001) {
        if (textField.text.length>14) {
            //
            [[HZMAPImanager shareMAPImanager]addDelegate:self];
            HZMRequest* requset=[[HZMRequest alloc]init];
            requset.requsetId=AccounBDcard_NetWoring;
            WDCAccount *a = [WDCUserManage getLastUserInfo];
            NSDictionary* dict=@{@"cardNum":textField.text,@"userId":a.userId};
            requset.requestParamDic=dict;
            requset.callBackDelegate=self;
            requset.tag=0x201;
            [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)nextAction:(id)sender {
    
    if(isNomal)
    {
        if (cellCard.input.text.length<14) {
            [self.view makeToast:@"银行卡号输入错误！" duration:1.5];
            return;
        }
        if (cellBank.input.text.length<2) {
            [self.view makeToast:@"开户银行未输入！" duration:1.5];
            return;
        }
        if(cellPro.input.text.length<2)
        {
            [self.view makeToast:@"省份未获取!" duration:1.5];
            return;
        }
        if (cellCity.input.text.length<2) {
            [self.view makeToast:@"城市未获取!" duration:1.5];
            return;
        }
        if(cellOpen.input.text.length<2)
        {
            [self.view makeToast:@"开户行支行未输入!" duration:1.5];
            return;
        }
        if ([cellMoney.input.text doubleValue]<startGet) {
            [self.view makeToast:[NSString stringWithFormat:@"提现金额必须大于起提金额:%0.2f元!",startGet] duration:1.5];
            return;
        }
        if ([cellMoney.input.text doubleValue]>syMoney) {
            [self.view makeToast:[NSString stringWithFormat:@"提现金额不能大于当日可提金额:%0.2f元!",syMoney] duration:1.5];
            return;
        }
        if([cellMoney.input.text floatValue]<=0 || [cellMoney.input.text floatValue]>useMoney)
        {
            [self.view makeToast:@"提现金额必须小余可提现金额，且大于0元!" duration:1.5];
            return;
        }
        WDCAccount *a = [WDCUserManage getLastUserInfo];
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary* dict=@{@"cardNum":cellCard.input.text,
                             @"cityCode":[cityDict objectForKey:@"no"],
                             @"braBankName":cellOpen.input.text,
                             @"userId":a.userId};
        //self.userMoney.text = [NSString stringWithFormat:@"      可提现金额(元):%ld",useMoney];
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=Bank_Card_Search;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x401;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
        return;
       // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
      /*  if (cellCard.input.text.length<14) {
            [self.view makeToast:@"银行卡号输入错误！" duration:1.5];
            return;
        }
        if (cellBank.input.text.length<2) {
            [self.view makeToast:@"开户银行输入错误！" duration:1.5];
            return;
        }
        WDCAccount *a = [WDCUserManage getLastUserInfo];
        NSDictionary* dict=@{@"cardNum":cellCard.input.text,
                             @"amount":@([cellMoney.input.text integerValue]),
                             @"provinceCode":@(provinCode),
                             @"cityCode":@(cityCode),
                             @"braBankName":braBank,
                             @"prcptcd":prcptcd,
                             @"userId":@([a.userId integerValue])};
        NSLog(@"kkk==%@",dict);
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=AccounTiXian_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x302;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];*/
        if([cellMoney.input.text floatValue]<=0 || [cellMoney.input.text floatValue]>useMoney)
        {
            [self.view makeToast:@"提现金额必须小余可提现金额，且大于0元!" duration:1.5];
            return;
        }
        if ([cellMoney.input.text doubleValue]>syMoney) {
            [self.view makeToast:[NSString stringWithFormat:@"提现金额不能大于当日剩余可提金额:%0.2f元!",syMoney] duration:1.5];
            return;
        }
        
    }
    InputDialog* dialog=[[InputDialog alloc]initWithNib];
    dialog.tag=0x3001;
    dialog.title.text=@"输入交易密码";
    [dialog.inputMessage setSecureTextEntry:YES];
    dialog.inputDelegate=self;
    [dialog show];
    
}

- (IBAction)xe:(id)sender {
    XianEVC *x = [[XianEVC alloc]init];
    [self.navigationController pushViewController:x animated:YES];
    
    
//    LLPayVC=[[LLPaySdk alloc]init];
//    LLPayVC.sdkDelegate=self;
}

- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)selectCityIndex:(id)selectCity atIndex:(NSInteger)index
{
    SelectCityDialog *city=selectCity;
    if (city.tag==0x1001) {
        provinceDict=[provinceArray objectAtIndex:index];
        cellPro.input.text=[provinceDict objectForKey:@"name"];
    }
    if (city.tag==0x1002) {
        cityDict=[cityArray objectAtIndex:index];
        cellCity.input.text=[cityDict objectForKey:@"name"];
    }
//    if([cellMoney.input.text integerValue]<1)
//    {
//        [self.view makeToast:@"金额必须大于1!" duration:1.5];
//        return;
//    }
    
    
}
-(void)inputMessage:(id)dialog theMessage:(NSString *)string
{
    if(string.length<1)
    {
        [self.view makeToast:@"交易密码未输入！" duration:1.5];
        return;
    }
    
    if (isNomal) {
        
        WDCAccount *a = [WDCUserManage getLastUserInfo];
        if (!prcptcd) {
            [self.view makeToast:@"银行卡，银行信息填有误！" duration:2];
            return;
        }
        NSDictionary* dict=@{@"cardNum":cellCard.input.text,
                             @"amount":@([cellMoney.input.text doubleValue]),
                             @"provinceCode":[provinceDict objectForKey:@"id"],
                             @"cityCode":[cityDict objectForKey:@"id"],
                             @"braBankName":cellOpen.input.text,
                             @"prcptcd":prcptcd,
                             @"userId":@([a.userId integerValue]),
                             @"tradePassword":[NSString MD5:string]};
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=AccounTiXian_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x302;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    }else{
        if (cellCard.input.text.length<14) {
            [self.view makeToast:@"银行卡号输入错误！" duration:1.5];
            return;
        }
        if (cellBank.input.text.length<2) {
            [self.view makeToast:@"开户银行输入错误！" duration:1.5];
            return;
        }
        WDCAccount *a = [WDCUserManage getLastUserInfo];
        NSDictionary* dict=@{@"cardNum":cellCard.input.text,
                             @"amount":@([cellMoney.input.text doubleValue]),
                             @"provinceCode":@(provinCode),
                             @"cityCode":@(cityCode),
                             @"braBankName":braBank,
                             @"prcptcd":prcptcd,
                             @"userId":@([a.userId integerValue]),
                             @"tradePassword":[NSString MD5:string]};
        NSLog(@"kkk==%@",dict);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HZMAPImanager shareMAPImanager]addDelegate:self];
        HZMRequest* requset=[[HZMRequest alloc]init];
        requset.requsetId=AccounTiXian_NetWoring;
        requset.requestParamDic=dict;
        requset.callBackDelegate=self;
        requset.tag=0x302;
        [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
@end
