//
//  Common.h
//  T98
//
//  Created by mythkiven on 15/9/1.
//  Copyright (c) 2015年 yunhoo. All rights reserved.
//


// devices.
#define iOS8        ([UIDevice currentDevice].systemVersion.floatValue >=8.0)
#define iOS7        ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) && ([UIDevice currentDevice].systemVersion.floatValue < 8.0)
#define iOS6        ([UIDevice currentDevice].systemVersion.floatValue >= 6.0) && ([UIDevice currentDevice].systemVersion.floatValue < 7.0)

#define iOS7_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 7.0
#define iOS8_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 8.0
#define iPad                [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad


// sandbox paths.
#define DocumentsPath       [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()]
#define LibraryPath         [NSString stringWithFormat:@"%@/Library", NSHomeDirectory()]
#define LibraryCachesPath   [NSString stringWithFormat:@"%@/Library/Caches", NSHomeDirectory()]
#define TmpPath             [NSString stringWithFormat:@"%@/tmp", NSHomeDirectory()]


//当前屏幕尺寸 
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_CENTERX  [UIScreen mainScreen].bound.size.width/2.0
#define SCREEN_CENTERY  [UIScreen mainScreen].bound.size.height/2.0
#define viewX(v)        v.frame.origin.x
#define viewY(v)        v.frame.origin.y
#define viewWidth(v)    v.frame.size.width
#define viewHeight(v)   v.frame.size.height

#define SelfViewWidth   self.view.bounds.size.width
#define SelfViewHeight  self.view.bounds.size.height

#define RGB(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB_red_alph3         RGB(239, 83, 68, 0.3)
#define RGB_red_alph6         RGB(239, 83, 68, 0.6)
/**通用暗红色*/
#define RGB_red         RGB(239, 83, 68, 1)
/**通用暗红色*/
#define RGB_yellow        RGB(242, 189,96, 1)
/**背景灰色*/
#define RGB_gray        RGB(241, 241, 241, 1)
#define RGB_gray115        RGB(115, 115, 115, 1)
/**状态栏标签栏灰色*/
#define RGB_grayBar     RGB(249, 249, 249, 1)
/**通用黑色*/
#define RGB_black        RGB(51, 51, 51, 1)

#define JDuration  2.0f


//应用主色
#define MAIN_COLOR RGB_gray

//侧边栏的宽度
#define SideButtonW     75.0
//侧边栏btn的高度
#define SideButtonH     100.0
//侧边栏btn的w文字
#define SideButtonText  14.0
//状态栏的高度
#define statusBarH      20
//导航条的高度
#define navBarH         44
#define navBarHText     20.0f

#define DeviceRect      [UIScreen mainScreen].bounds
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height
#define DeviceWidth     [UIScreen mainScreen].bounds.size.width


//AlertTag
#define kAlertVersionUpdataAlertIsForce  1234
#define kAlertVersionUpdataAlertIsNotForce  1235
#define kAlertPersionData_EndMatch  1236
#define kAlertPersionData_DianQiuZhiShen  1237
#define kAlertDirectData_shujutongji  1238
#define kAlertMore_shujutongji  1239
#define kAlertMore_shujutongji_Two  1241
#define kAlertMore_tuichudenglu  1242

//#define kPersionData_EndMatch  113
//#define kPersionData_EndMatch  114

//是否已经登录：
#define kLogined @"kLogined"

//宏定义 :储存已经进入的页面
#define MatchBeginTime @"kaishishijian"

#define ActivityNum @"dingyiyemian"
#define HuoDongHao @"huodonghaozaici"
//NSUserDefaults里面的userId == oprId
#define userOrOperID @"userId"
#define userOrOperIDCopy @"oprId"

#define Version @"Version"
//沙河里面的version -- key
#define Version @"Version"

#define keyRequsetId   @"TXNCODE"
#define keyParamDic    @"reqStr"
//结果状态码
#define keyRescode  @"rescode"
#define valueRescode  @"0" //0成功
//结果状描述
#define keyResdes   @"resdes"

//赛事规格：
#define keyMatchType    @"type"

//比赛ID-活动id:NSUserD储存
#define keyMatchId      @"matchId"

//是否点球制胜
#define keyPersionDianQiu @"keyPersionDianQiu"
//本地暂停时长
#define keyPauseTime      @"keyPauseTime"
// key_value：
// 10601
#define keyVersion      @"version"
#define valueVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 系统标志
#define keySysflag      @"sysflag"
#define valueSysflag    @"N2"
// 扫描设备id
#define keyScannerId    @"scannerId"
#define valueScannerId  [[[UIDevice currentDevice].identifierForVendor.UUIDString componentsSeparatedByString:@"-"] lastObject]
// 10602
//用户名
#define keyUserName  @"userName"
//用户密码
#define keyUserPwd  @"userPwd"




// key：
// 10602
// Value：


//字体
#define themeFont20     [UIFont systemFontOfSize:20.0f]
#define themeFont17     [UIFont systemFontOfSize:17.0f]
#define themeFont15     [UIFont systemFontOfSize:15.0f]
#define themeFont14     [UIFont systemFontOfSize:14.0f]
#define themeFont13     [UIFont systemFontOfSize:13.0f]
#define themeFont12     [UIFont systemFontOfSize:12.0f]
#define themeBoldFont13   [UIFont boldSystemFontOfSize:13]
#define themeBoldFont15   [UIFont boldSystemFontOfSize:15]
#define themeBoldFont17   [UIFont boldSystemFontOfSize:17]

#define UUID  [UIDevice currentDevice].identifierForVendor.UUIDString


//沙盒路径
#define DOUCMENTS_DIRECYTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//当前版本号
#define CURRENT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//当前语言
#define CURRENT_INTERNATIONAL [NSString stringWithFormat:@"%@", @"cn"]

#define PARAM_IS_NIL_ERROR(param) ((param == nil || [param isKindOfClass:[NSNull class]]) ? @"" : param)
#define PARAM_IS_NIL_ERROR_MONEY(param) ((param == nil) ? @"0.00" : param)

#define PARAM_IS_NIL_PLACEHOLDER(param, placeholder) ((param == nil) ? placeholder : param)






