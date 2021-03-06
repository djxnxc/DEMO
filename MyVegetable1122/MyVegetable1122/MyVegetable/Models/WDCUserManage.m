//
//  ZendaiUserManage.m
//  ZenDaiWallet
//

//
//

#import "WDCUserManage.h"
//#import "WDCAccount.h"


//extern WDCAccount *g_account;
@interface WDCUserManage ()



@end


@implementation WDCUserManage


+(void)saveLastUserInfo:(WDCAccount *)g_account{
    if (g_account.userId) {
        NSMutableDictionary *userInfoDic = [NSMutableDictionary new];
        
        [userInfoDic setObject:g_account.userId forKey:@"userId"];
        if (g_account.userName) {
            [userInfoDic setObject:g_account.userName forKey:@"userName"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.handPassword) forKey:@"handPassword"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.idCard) forKey:@"idCard"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.bankId) forKey:@"bankId"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.pas) forKey:@"password"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.cardId) forKey:@"cardId"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.bankName) forKey:@"bankName"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.bankCardNumber) forKey:@"bankCardNumber"];
            [userInfoDic setObject:PARAM_IS_NIL_ERROR(g_account.mobile) forKey:@"mobile"];
            

        }
        [[NSUserDefaults standardUserDefaults] setObject:userInfoDic forKey:LAST_USER_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(WDCAccount *)getLastUserInfo{
    
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefatluts objectForKey:LAST_USER_INFO];
    
    if (userDic) {
        WDCAccount *account = [WDCAccount new];
        
        account.userId = [userDic objectForKey:@"userId"];
        account.userName = [userDic objectForKey:@"userName"];
        account.handPassword = [userDic objectForKey:@"handPassword"];
        account.identityName = [userDic objectForKey:@"identityName"];
        account.idCard = [userDic objectForKey:@"idCard"];
        account.bankId = [userDic objectForKey:@"bankId"];
        account.pas=[userDic objectForKey:@"password"];
        account.cardId = [userDic objectForKey:@"cardId"];
        account.bankName = [userDic objectForKey:@"bankName"];
        account.bankCardNumber = [userDic objectForKey:@"bankCardNumber"];
        account.inviteCode = [userDic objectForKey:@"inviteCode"];
        
        if ([[userDic objectForKey:@"mobileValidate"] integerValue] == 1)
            account.mobileValidate = YES;
        
        if ([[userDic objectForKey:@"idcardValidate"] integerValue] == 1)
            account.idcardValidate = YES;
        
        
        account.mobile = [userDic objectForKey:@"mobile"];
        account.email = [userDic objectForKey:@"email"];

        
            
        return account;
    }
    
    return nil;
    
    
    
}

+ (void)removeLastUserInfo{
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    [userDefatluts removeObjectForKey:LAST_USER_INFO];
    [userDefatluts synchronize];
}

+ (WDCUserManage *)sharedWDCUserManage
{
    static dispatch_once_t once;
    static WDCUserManage *wdcwebService;
    
    dispatch_once(&once, ^{
        wdcwebService = [[self alloc] init];
    });
    return wdcwebService;
}

@end
