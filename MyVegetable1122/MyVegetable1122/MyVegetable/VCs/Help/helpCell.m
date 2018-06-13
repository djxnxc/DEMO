//
//  helpCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "helpCell.h"
#import "helpModel.h"
#import "AccountModel.h"
@implementation helpCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setHelpmodel:(helpModel *)helpmodel {
    self.w.constant = 18.0*ratioW;
    self.h.constant = 20.0*ratioW;
    if (helpmodel.detailTitle) {
        self.detailTitle.hidden = NO;
        self.detailTitle.text = helpmodel.detailTitle;
    }else{
       self.detailTitle.hidden = YES;
    }
    
    self.title.text = helpmodel.title;
    self.title.font = JFont(fontMid);
    self.detailTitle.font = JFont(fontSmall);
    [self.image setImage:[UIImage imageNamed:helpmodel.image]];
    [self.imgeNext setImage:[UIImage imageNamed:helpmodel.imageNext]];

    
}
- (void)setAccountmodel:(AccountModel *)accountmodel{
    self.w.constant = 16.0*ratioW;
    self.h.constant = 20.0*ratioW;
    self.title.text = accountmodel.title;
    if (accountmodel.detailTitle) {
        NSString *sst = [NSString stringWithFormat:@"%@",accountmodel.detailTitle];
        //sst = sst];
        
        self.detailTitle.text =[NSString stringWithFormat:@"%@", sst];
    }else {
        self.detailTitle.hidden = YES;
    }
    self.title.font = JFont(fontMid);
    self.detailTitle.font = JFont(fontSmall);
    [self.image setImage:[UIImage imageNamed:accountmodel.image]];
    [self.imgeNext setImage:[UIImage imageNamed:accountmodel.imageNext]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
    if (self.helpmodel) {
        self.w.constant = 18.0*ratioW;
        self.h.constant = 16.0*ratioW;
        self.detailTitle.hidden = YES;
    }
}
@end