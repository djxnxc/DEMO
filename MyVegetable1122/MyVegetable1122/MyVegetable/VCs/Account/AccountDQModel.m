//
//  AccountDQModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/24.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountDQModel.h"

@implementation AccountDQModel
- (id)initWithDicc:(NSDictionary *)dic{
//    self.topleftUp = dic[@"hadShare"];
//    self.toprightUp = dic[@"expectedInterest"];
    if (self) {
        self.leftUp = [[NSString stringWithFormat:@"%@",dic[@"rate"]] stringByAppendingString:@"%"];
        self.leftDOwn = [NSString stringWithFormat:@"%@",dic[@"title"]];
        NSString *ss = [NSString stringWithFormat:@"%@",dic[@"hadShare"]];
        ss = [NSString countNumAndChangeformat:ss];
        self.midUp = [NSString stringWithFormat:@"持有份额%@",ss];
        
        NSString *sts = [NSString stringWithFormat:@"%@",dic[@"expectedAmount"]];
        sts = [NSString countNumAndChangeformat:sts];
        self.midDown = [NSString stringWithFormat:@"预期收益%@",sts];
#warning 注意此处！！
        self.rightUp = @"到期日";
        self.rightDown =[NSString stringWithFormat:@"%@", dic[@"dueDate"]];
        if (self.rightDown.length>7) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date=[dateFormatter dateFromString:self.rightDown];
            NSDate* tdate=[NSDate date];
            NSDate* earl=[tdate earlierDate:date];
            if ([earl isEqualToDate:tdate]) {
                self.isStop=NO;
            }else {
                self.isStop=YES;
                self.rightUp=@"已到期";
            }
            
            
        }
    }
    return self;
}

//                AccountDQModel *model = [[AccountDQModel alloc] initWithDic:dic];
//                model.leftUp = [NSString stringWithFormat:@"%d",i+2];
//                model.leftDOwn = [NSString stringWithFormat:@"%d个月定期",self.pageNum];
//                model.midUp = [NSString stringWithFormat:@"持有份额￥%d",i*20];
//                model.midDown = [NSString stringWithFormat:@"预期收益￥%d",i*30];
//                model.rightUp = [NSString stringWithFormat:@"%@",i/2?@"已到期":@"到期日"];
//                model.rightDown = [NSString stringWithFormat:@"%@",i/2?@"2015/11/11":@"2016/11/11"];


@end
