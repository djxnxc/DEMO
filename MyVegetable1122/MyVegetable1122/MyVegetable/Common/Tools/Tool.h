//
//  Tool.h
//
//  Created by 蒋孝才 on 15/7/6.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#define isNetWorking @"isNetWorking"

@interface Tool : NSObject

+ (instancetype)shareTool;
+(NSString *) md5: (NSString *) inPutText ;
+ (void)setObject:(id)object forKey:(NSString *)key;
+ (void)setBool:(BOOL)b forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;
+ (NSString*)calculateCatcheSize;
+ (CGFloat)calculateTextHeight:(NSString*)text size:(CGSize)size font:(UIFont*)font;
+ (NSString *)deviceIdentifier;
+ (void)checkNetWork;
- (BOOL)isMobileNumber:(NSString *)mobileNum;
- (BOOL)validateIdentityCard:(NSString *)identityCard;
- (BOOL)validateEmail:(NSString *)email;
- (BOOL)isNumText:(NSString *)str;
+ (BOOL) validateEmail:(NSString *)email;
+(void)clearStatus;
+(BOOL)validateIsNumberChar:(NSString*)string;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//数字或字母
+ (BOOL)validateLetterOrNumber: (NSString *)string;

+(UILabel *)setLabel:(UILabel *)label withFrom:(int)a to:(int)b andfont:(NSInteger)font withColor:(UIColor *)color;


@end
