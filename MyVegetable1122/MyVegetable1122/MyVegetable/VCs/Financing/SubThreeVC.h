//
//  SubViewController.h
//  PageViewController
//
//  Created by 蒋孝才 on 15/8/6.
//  Copyright (c) 2015年 ShiShu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrowCircle,PICircularProgressView;
@interface SubThreeVC : UIViewController
{
    CGAffineTransform currentTransform;
    CGAffineTransform newTransform;
    double r;
    CGFloat progress;
}
@property (strong, nonatomic) PICircularProgressView *progressView;
@property (nonatomic , strong)  NSTimer *theTimer;
@property(nonatomic,strong)DrowCircle * circleChart;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerv;

@property (nonatomic, copy) NSString *urlStr;
@property(nonatomic,strong)UINavigationController* nc;
@property (nonatomic,assign) NSInteger pageNum;
@end
