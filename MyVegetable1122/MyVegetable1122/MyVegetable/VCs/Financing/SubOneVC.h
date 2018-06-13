//
//  SubViewController.h
//  PageViewController
//
//  Created by 蒋孝才 on 15/8/6.
//  Copyright (c) 2015年 ShiShu. All rights reserved.
//


#import <UIKit/UIKit.h>
@class DrowCircle,PICircularProgressView;
@interface SubOneVC : UIViewController<UIScrollViewDelegate>
{
    CGAffineTransform currentTransform;
    CGAffineTransform newTransform;
    double r;
    CGFloat progress;
}
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollerv;
@property (strong, nonatomic) PICircularProgressView *progressView;
@property (nonatomic , strong)  NSTimer *theTimer;
@property(nonatomic,strong)DrowCircle * circleChart;
@property(nonatomic,strong)UINavigationController* fathers;
@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic,assign) NSInteger pageNum;
@end