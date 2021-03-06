//
//  AccountDQSubOneCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJLSubTwoCell.h"
#import "AccountJLModel.h"
@implementation AccountJLSubTwoCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(AccountJLModel *)model {
    self.statusShow.text=model.statusName;
        if ([model.isUseOrold isEqualToString: @"1"]) {//未使用
            [self.isUseOrold setImage:[UIImage imageNamed:@"strGe.png"]];
            [self.hongbaoBg setImage:[UIImage imageNamed:@"account_ticket pink"]];
            [self.hongbaoXX setImage:[UIImage imageNamed:@"account_lv"]];
        }else{
            [self.isUseOrold setImage:[UIImage imageNamed:@"staG.png"]];
            [self.hongbaoBg setImage:[UIImage imageNamed:@"account_ticket pink -shixiao"]];
            [self.hongbaoXX setImage:[UIImage imageNamed:@"xuxian1"]];
            self.monkey.textColor = RGB(117, 117, 117, 1);
        }
    NSString *s = [NSString countNumAndChangeformat:model.monkey];
        self.monkey.text = [NSString stringWithFormat:@"￥%@",s];
        self.type.text = @"类型:体验金";
    
        self.effect.text = [NSString stringWithFormat:@"有效期:%@",model.effect];
    if (model.condition) {
        
        self.condition.text = [NSString stringWithFormat:@"使用规则:%@",model.condition];
    }
        self.hongbaoMonkey.text = [NSString stringWithFormat:@"￥%@",s];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
