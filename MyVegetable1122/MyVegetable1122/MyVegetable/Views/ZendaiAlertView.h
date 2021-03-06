//
//  ZendaiAlterview.h
//  new

#import <UIKit/UIKit.h>
@class ZendaiAlertView ;
@interface ZendaiAlertView : UIView
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (id)initWithTitle:(NSString *)title
        contentText:(NSMutableAttributedString *)content
      textAlignment:(NSTextAlignment)textAlignment
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;
- (void)show;
@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, strong) UIColor *leftColor;
@property (nonatomic, strong) UIColor *rightColor;
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property(nonatomic,strong)UIButton *cha;

+(ZendaiAlertView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle;

-(void)removeFromSuperviewi;

@end
