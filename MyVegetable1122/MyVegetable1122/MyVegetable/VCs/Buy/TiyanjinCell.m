//
//  TiyanjinCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/12/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "TiyanjinCell.h"

@implementation TiyanjinCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)change:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(tyjChoose:)]) {
        
    }
    
        [self.delegate tyjChoose:sender father:self];
    
}
- (void)setModell:(Tiyanjin *)modell {
   
        
    self.title.hidden = NO;
    self.choose.hidden = NO;
    if (modell.status==1) {
        if (self.choose.isOn == YES) {
            self.choose.on = YES;
        }else{
            self.choose.on = NO;
        }
    }else{
        self.choose.on = NO;
            self.choose.enabled=NO;
        }
    //self.modell=modell;
    NSString *s = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%@",modell.amount]];
    self.title.text = [NSString stringWithFormat:@"%@:%@元",modell.getMode ,s];
    NSRange sub=[self.title.text rangeOfString:@":"];
    [self setFontColorLabel:self.title :sub.location+1 :s.length];
    self.amountValue=modell.amount;
    self.choose.tag = [modell.couponId integerValue];
    
    
}

-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    NSRange r =  NSMakeRange(a, b);
    [att addAttributes:@{NSForegroundColorAttributeName:RGB_red,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
