//
//  AccountTiXianViewController.h
//  MyVegetable
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZMAPImanager.h"
#import "SelectCityDialog.h"
#import "InputCellTableViewCell.h"
#import "MBProgressHUD.h"
#import "InputDialog.h"
#import "XianEVC.h"
@interface AccountTiXianViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HZMAPIManagerDelegate,UITextFieldDelegate,SelectCityDelegate,InputDelegate>
{
    BOOL isNomal;
    InputCellTableViewCell* cellCard,*cellBank,*cellPro,*cellCity,*cellOpen,*cellMoney;
    UITableViewCell* ce1,*ce2;
    NSDictionary* provinceDict,*cityDict;
    NSArray* provinceArray,*cityArray;
    double useMoney;
    NSDictionary* myCardInfo;
    CGRect tableDefault;
    NSString* prcptcd;//大额行号
    NSString* braBank;//有卡银行支行
    NSInteger provinCode,cityCode;//省，市id
    BOOL isTrue,isPassword;
    BOOL isGetBound;
    double startGet;//起提金额
    double syMoney;//剩余可提金额
}
@property (strong, nonatomic) IBOutlet UIView *bbv;

@property (strong, nonatomic) IBOutlet UILabel *handMoney;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UITableView *cardTable;
@property (strong, nonatomic) IBOutlet UILabel *userMoney;
@property (strong, nonatomic) IBOutlet UILabel *cardFeiyong;
- (IBAction)nextAction:(id)sender;
- (IBAction)xe:(id)sender;


- (IBAction)backView:(id)sender;
@end