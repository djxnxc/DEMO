//
//  Account.m


#import "WDCAccount.h"

@implementation WDCAccount

-(void)clear
{
    self.userId=nil;
    self.userName=nil;
    self.handPassword=nil;
    self.identityName=nil;
    self.bankName=nil;
    self.bankCardNumber=nil;
    self.inviteCode=nil;
    self.ftpPathDispose=nil;
    self.ftpPathOriginal=nil;
    self.lockStatus=NO;
    self.setLock=NO;
    
    self.emailValidate=NO;
    self.mobileValidate=NO;
    self.idcardValidate=NO;
    self.email=nil;
    self.mobile=nil;
    
    self.uuid = nil;
}


- (id) decode:(NSDictionary *)dataDic
{
    self.userId = [PARAM_IS_NIL_ERROR([dataDic objectForKey:@"id"]) stringValue];
    self.mobile = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"mobile"]);
    self.userName = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"userName"]);
    self.idCard = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"idCard"]);
    self.pas=[dataDic objectForKey:@"password"];
#warning 注意此处的陷阱！！！已经return了
    if (![dataDic objectForKey:@"email"]) {
        return self;
    }
    self.identityName = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"identityName"]);
    self.email = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"email"]);
    
    self.uuid = PARAM_IS_NIL_ERROR([dataDic objectForKey:@"uuid"]);
    

    return self;
}
+ (WDCAccount*)sharedWDCAccount
{
    static dispatch_once_t once;
    static WDCAccount *wdcwebServiceaa;
    
    dispatch_once(&once, ^{
        wdcwebServiceaa = [[self alloc] init];
    });
    return wdcwebServiceaa;
}

@end
