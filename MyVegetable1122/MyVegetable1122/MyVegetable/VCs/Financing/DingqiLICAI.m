//
//  DingqiLICAI.m
//  LTInfiniteScrollView
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 ltebean. All rights reserved.
//

#import "DingqiLICAI.h"
#import "DingLICAIModel.h"
#import "BuyModel.h"
@implementation DingqiLICAI

- (IBAction)clickedBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickedDetailBtnn:)]) {
        [self.delegate didClickedDetailBtnn:sender];
    }
}

+(instancetype)viewWith:(NSString *)str {
  
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *objs = [bundle loadNibNamed:@"DingqiLICAI" owner:nil options:nil];
    DingqiLICAI *appView = [objs lastObject];
    appView.layer.cornerRadius = appView.bounds.size.width/2;
    appView.layer.masksToBounds = YES;
    appView.str = str;
    return appView;
    
    
}
- (void)setDmodel:(DingLICAIModel *)dmodel {
    
   
    if ([dmodel.smallTitle isEqualToString:@"Null"]) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    self.backgroundColor = [UIColor clearColor];
    self.lastLabel.text = dmodel.smallTitle;
    BOOL ji=YES;
    if (dmodel.smallTitle) {
        ji=NO;
    }
    if (dmodel.model&&ji) {
        self.per.text = dmodel.title;
        BuyModel *model =dmodel.model;
        if ([dmodel.model isKindOfClass:[DingLICAIModel class]]) {
            DingLICAIModel *mmm = dmodel.model;
            model= mmm.model;
        }else{
            model = dmodel.model;
        }
        if (dmodel.model) {
            
            if (model.minRate) {
                NSString *min = [NSString stringWithFormat:@"%.2lf",model.minRate];
                min = [min stringByAppendingString:@"%"];
                NSString *max = [NSString stringWithFormat:@"%.2lf",model.maxRate];
                max = [max stringByAppendingString:@"%"];
                self.per.text=[NSString stringWithFormat:@"%@",min];
                
                int a = (int)self.per.text.length;
                a--;
                NSRange r1 = [min rangeOfString:@"."];
                NSString *rs1 = [min substringToIndex:r1.location];
                NSRange r2 = [max rangeOfString:@"."];
                NSString *rs2 = [max substringToIndex:r2.location];
                [self setFontColorLabel:self.per :0 :rs1.length];
                [self setFontColorLabel:self.per :a-max.length+1 :rs2.length];
                
            }else{
                NSString *max = [NSString stringWithFormat:@"%.2lf",model.maxRate];
                max = [max stringByAppendingString:@"%"];
                self.per.text=[NSString stringWithFormat:@"%@",max];
                
                int a = (int)self.per.text.length;
                a--;
                [self setFontColorLabel:self.per :0 :1];
            }
            
        }
    }
    if (dmodel.title.length) {
        self.per.text = dmodel.title;
        int a = (int)self.per.text.length;
        a--;
        [self setFontColorLabel:self.per :0 :1];
    }
    
    
    [self.bg setImage:[UIImage imageNamed:dmodel.icon]];
    [self.lastImg setImage:[UIImage imageNamed:dmodel.icon]];
    
    
    
    if (dmodel.smallTitle) {
        self.lastLabel.hidden= NO;
        self.lastImg.hidden = NO;
        self.bg.hidden = YES;
        self.nianhuaLabel.text = @"";
        self.per.text = @"";
        [self.chanpinBtn setTitle:@"" forState:UIControlStateNormal];
    }else{
        self.lastLabel.hidden = YES;
        self.lastImg.hidden = YES;
        self.bg.hidden = NO;
        self.nianhuaLabel.text = @"年化收益率";
        [self.chanpinBtn setTitle:@"产品详情>" forState:UIControlStateNormal];
    }
    
}
- (void)setStr:(NSString *)str {
    self.per.text = str;
    self.lastLabel.hidden= YES;
//    [self setFontColorLabel:self.per :0 :(int)str.length-1];
}

-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    if (a<0|b<0) {
        return;
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}

- (void)layoutSubviews {
    if (iPhone6) {
        self.lastLabel.font = JFont13;
        self.UIVEW.frame = CGRectMake(0, 0, 180, 180);
        self.TopH.constant = 50;
        self.Uplabel.font = JFont13;
        self.UpLabelH.constant = 25;
        self.MidLabelH.constant = 33;
        self.boomBtn.titleLabel.font = JFont13;
        self.BoomLabelH.constant =25;
        _W.constant = 52;
        _H.constant = 52;
    } else if (iPhone6P) {
        self.lastLabel.font = JFont13;
        self.UIVEW.frame = CGRectMake(0, 0, 180, 180);
        self.TopH.constant = 60;
        self.Uplabel.font = JFont14;
        self.UpLabelH.constant = 30;
        self.MidLabelH.constant = 39;
        self.boomBtn.titleLabel.font = JFont14;
        self.BoomLabelH.constant =25;
        _W.constant = 62;
        _H.constant = 62;
    }
    [self.bg setImage:[UIImage imageNamed:@"financing_huoqi_bg.png"]];
//    [self setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"financing_huoqi_bg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
}
@end
