//
//  Networking.h
//  MyVegetable
//
//  Created by mythkiven on 15/12/6.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#ifndef Networking_h
#define Networking_h

//注册登录模块接口
//**登录*/
#define Tagteshu   13971
#define Login_NetWoring                 @"/login.p2p"
//注册
//**获取图片验证码-注册用验证码*/
#define LoginYZMGetImg_NetWoring        @"/code.p2p"
//**图片验证码-校验-是否可以注册*/
#define LoginYZMTestImg_NetWoring       @"/isRegist.p2p"
//**注册*/
#define LoginZC_NetWoring               @"/regist.p2p"
//重置
//**获取短信验证码-获取*/
#define LoginYZMGetSMS_NetWoring        @"/sms/send.p2p"
//**校验短信验证码-校验*/
#define LoginYZMTestSMS_NetWoring       @"/sms/validate.p2p"
//**重置密码-登录+交易*/
#define LoginCZMM_NetWoring             @"/password/reset.p2p"

//首页
//**图片轮播*/
#define HomePageTopImg_NetWoring        @"/advertisementImage.p2p"
//**幸运大转盘奖励接口*/
#define HomePageZP1_NetWoring           @"/u/randomDialReward.p2p"
//**幸运大转盘奖励查询接口*/
#define HomePageZP2_NetWoring           @"/u/getdialReward.p2p"
//**邀请码接口*/
#define HomePageYQM_NetWoring           @"/u/getInviteCode.p2p"
//**产品概要接口*/
#define HomePageCPGYdetail_NetWoring    @"/queryProdInfo.p2p"

//**产品详情接口*/
#define FinancingCPXQdetail_NetWoring   @"/queryProdDetailIntroduce.p2p"
//**定期产品查询*/
#define FinancingDQCPchaxun_NetWoring   @"/queryProdInfo.p2p"
//**投资购买*/
#define FinancingGMPay_NetWoring        @"/u/investPurchase.p2p"

//账户
//**我的账户信息总览*/
#define AccounTotal_NetWoring           @"/u/myAccountInfo.p2p"
//**我的定期查询*/
#define AccounDingQiCX_NetWoring        @"/u/queryMyRegularLoan.p2p"
//**我的活期查询*/
#define AccounHuoQiCX_NetWoring         @"/u/queryMyCurrentLoan.p2p"
//**活期收益列表查询*/
#define AccounHuoQiSY_NetWoring         @"/u/queryMyCurrentIncomeList.p2p"

//**赎回金额计算*/
#define AccounShuHuiJE_NetWoring          @"/u/redeemCal.p2p"
//**赎回*/
#define AccounShuHui_NetWoring            @"/u/redeem.p2p"
//**利息计算*/
#define AccounShuHuiLiXi_NetWoring        @"/u/redeemCal.p2p"

//**我的交易记录*/
#define AccounJiaoyijilu_NetWoring      @"/u/MyTradeRecord.p2p"
//**我的奖励查询*/
#define AccounJiangLi_NetWoring         @"/u/getMyReward.p2p"
//**实名认证*/
#define AccounNameSure_NetWoring        @"/u/idCard/validate.p2p"
//**登录/交易修改密码*/
#define AccounXGMMa_NetWoring           @"/u/password/modify.p2p"
//**查找银行卡*/
#define AccounCZCard_NetWoring          @"/u/bankcard/list.p2p"
//**银行卡绑定查询*/
#define AccounBDcard_NetWoring          @"/u/bankcard/cardbin.p2p"
//**解绑银行卡*/
#define AccounJieBangcrad_NetWoring     @"/u/bankcard/remove.p2p"
//**红包提现*/
#define AccounHongBaoTiXian_NetWoring   @"/u/extractReward.p2p"
//**提现*/
#define AccounTiXian_NetWoring          @"/u/withdraw.p2p"
//**提现跳转**/
#define AccountTiXian_Jump              @"/u/extract/goto.p2p"
/**充值跳转**/
#define AccountChongZhi_Jump           @"/u/recharge/goto.p2p"
//**省市*/
#define ShengshiProvinceCity_NetWoring  @"/getProvinceAndCity.p2p"
/*大额行号查询接口*/
#define Bank_Card_Search                @"/u/bankcard/cnaps.p2p"
//**第三方支付*/
#define AccounZhiFu_NetWoring           @"/u/encrypt.p2p"
//**常见问题*/
#define HelpCJWTi_NetWoring             @"/getQuestion.p2p"
//**活动中心*/
#define HelpHuoDZX_NetWoring            @"/activityCenter.p2p"
//**三方加密通道**
#define Account_ThirdMD5                @"/u/recharge.p2p"
//**首页图片*/
/*用户信息查询*/
#define Check_Info                      @"/u/checkUserInfo.p2p"
/*立即预约*/
#define User_Appointment                @"/u/appointmentApply.p2p"
/*定期菜单列表*/
#define Dq_MenuList                     @"/u/queryMyRegularMenuList.p2p"
/*活动分享*/
#define Activity_Connect                @"/u/shareActivity.p2p"
/*初次设置交易密码*/
#define Set_tradePwd  @"/u/setTradePwd.p2p"

/*投资购买跳转接口*/
#define Buy_Jump                        @"/u/investPurchaseGoto.p2p"


#define HomePagePICTUER_NetWoring  @"http://116.226.191.6:9081/web"
//图片地址
#define ResourUrl         @"http://static.wdclc.cn"        //@"http://www.yunhoo.com.cn/zyp2p"




#endif /* Networking_h */
