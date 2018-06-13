//
//  AccountDQSubOne.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountDQSubOne.h"
#import "AccountDQModel.h"
#import "AccountDQSubOneCell.h"
#import "BuyOne.h"
#import "PublicString.h"
@interface AccountDQSubOne ()<UITableViewDataSource,UITableViewDelegate,HZMAPIManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *chiyou;
@property (weak, nonatomic) IBOutlet UILabel *yuqi;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *get;
- (IBAction)clickedGet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
@end

@implementation AccountDQSubOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerNib:[UINib nibWithNibName:@"AccountDQSubOneCell" bundle:nil] forCellReuseIdentifier:@"AccountDQSubOneCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle       = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.data = [NSMutableArray arrayWithCapacity:0];
    
    self.view.backgroundColor = RGB_gray;
    self.chiyou.text = [NSString stringWithFormat:@"￥0.00"];
    self.yuqi.text = @"￥0.00";
//    [self datai];
    
     __weak UITableView *tableView = self.tableView;
    //下拉率刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             if (self.pageNum == 1)     [self getProduct:@"3":@"12"];
        else if (self.pageNum == 3)     [self getProduct:@"3":@"32"];
        else if (self.pageNum == 6)     [self getProduct:@"3":@"62"];
        else if (self.pageNum == 9)     [self getProduct:@"3":@"122"];
        else if (self.pageNum == 99)    [self getProduct:@"2":@"1"];
        [tableView.header endRefreshing];
    }];
    // 上啦刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
             if (self.pageNum == 1)     [self getProduct:@"3":@"12"];
        else if (self.pageNum == 3)     [self getProduct:@"3":@"32"];
        else if (self.pageNum == 6)     [self getProduct:@"3":@"62"];
        else if (self.pageNum == 9)     [self getProduct:@"3":@"122"];
        else if (self.pageNum == 99)    [self getProduct:@"2":@"1"];
        [tableView.footer endRefreshing];
    }];
    
    
    
    //    立即抢购
    self.btnH.constant = 30.0*ratioH;
    self.get.layer.cornerRadius = 30.0/2*ratioH;
    self.get.layer.masksToBounds = YES;
    [self.get setBackgroundColor:RGB_yellow];
    self.get.titleLabel.font = JFont(fontBtn);
    [self.get setTitle:@"购买" forState:UIControlStateNormal];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*
    if (self.pageNum == 1)     [self getProduct:@"3":@"12"];
    else if (self.pageNum == 3)     [self getProduct:@"3":@"32"];
    else if (self.pageNum == 6)     [self getProduct:@"3":@"62"];
    else if (self.pageNum == 12)     [self getProduct:@"3":@"122"];
    else if (self.pageNum == 99)    [self getProduct:@"2":@"1"];
    */
    if (From1(self)|From2(self)) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    [self reflash];
}

-(void)reflash
{
    [self.data removeAllObjects];
    [self.tableView reloadData];
    self.chiyou.text =[NSString stringWithFormat:@"￥%@",@"0.00"];
    self.yuqi.text = [NSString stringWithFormat:@"￥%@",@"0.00"];
    if (self.dataDictionary) {
        [self getProduct:[self.dataDictionary objectForKey:@"prodType"] :[self.dataDictionary objectForKey:@"timeType"] ];
    }
}
//- (void)datai {
//    for (int i=0; i<self.pageNum; i++) {
//        AccountDQModel *model = [[AccountDQModel alloc] init];
//        model.leftUp = [NSString stringWithFormat:@"%d",i+2];
//        model.leftDOwn = [NSString stringWithFormat:@"%ld个月定期",self.pageNum];
//        model.midUp = [NSString stringWithFormat:@"持有份额￥%d",i*20];
//        model.midDown = [NSString stringWithFormat:@"预期收益￥%d",i*30];
//        model.rightUp = [NSString stringWithFormat:@"%@",i/2?@"已到期":@"到期日"];
//        model.rightDown = [NSString stringWithFormat:@"%@",i/2?@"2015/11/11":@"2016/11/11"];
//        
//        [self.data addObject:model];
//    }
//}

#pragma mark - 购买
- (IBAction)clickedGet {
    
    
}
#pragma mark - 网络
- (void)getProduct:(NSString *)type:(NSString *)timetype {
//    if(timetype)
//    {
//        timetype=@"";
//    }
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary *dicParams =[NSDictionary dictionaryWithObjectsAndKeys:
                              a.userId,@"userId",
                              timetype,@"timeType",
                              type,@"type",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] addDelegate:self];
    HZMRequest *request =[[HZMRequest alloc] init];
    request.requsetId = AccounDingQiCX_NetWoring;
    request.requestParamDic = dicParams;
    request.callBackDelegate = self;
    request.tag = 0;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:request];
}

- (void)transactionFinished:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[HZMAPImanager shareMAPImanager] removeDelegate:self];
    if ([response.requestId isEqualToString:AccounDingQiCX_NetWoring]) {
        if ([response.responseCodeOriginal isEqualToString:@"1"]) {
            NSDictionary *dictt= [response.responseData objectForKey:@"data"];
            NSString *ss = [NSString stringWithFormat:@"%@",dictt[@"hadShare"]];
            ss = [NSString countNumAndChangeformat:ss];
            self.chiyou.text =[NSString stringWithFormat:@"￥%@",ss];
            
            NSString *sts = [NSString stringWithFormat:@"%@",dictt[@"expectedInterest"]];
            sts = [NSString countNumAndChangeformat:sts];
            self.yuqi.text = [NSString stringWithFormat:@"￥%@",sts];
             NSArray *arr= [dictt objectForKey:@"myRegularInvestList"];
            if (arr.count==0) {
                [self.view makeToast:@"暂无数据" duration:2.0f ];
                return;
            }
            [self.data removeAllObjects];
            for (NSDictionary *dic in arr) {
                AccountDQModel *model = [[AccountDQModel alloc] initWithDicc:dic];
                
                [self.data addObject:model];
                [self.tableView reloadData];
            }
            
            
        }
    }
}
- (void)transactionFailed:(HZMResponse *)response {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountDQModel *model = self.data[indexPath.row];
    static NSString *AccountDQCellID = @"AccountDQSubOneCell";
    AccountDQSubOneCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountDQCellID];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor whiteColor];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
