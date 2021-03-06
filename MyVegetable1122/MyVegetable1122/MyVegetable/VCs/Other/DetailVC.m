//
//  AccountDQ.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "DetailVC.h"
#import "DetailVCSubOne.h"
#import "MainTabbarController.h"
#import "FinancingVC.h"

@interface DetailVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,HZMAPIManagerDelegate>
{
    UIPageViewController *_pageViewController;
    //数据源
    NSMutableArray *_vcArray;
    //标识当前页
    NSInteger _curPage;
    //标题scrollView
    UIScrollView *_titleScrollView;
    //指示当前页
    UIView *_indicatorView;
}

@property (weak, nonatomic) IBOutlet UIView *indView;
@property (weak, nonatomic) IBOutlet UIView *contetnView;



@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
    
    [self configUI];
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    if (self.isfrom == 22|self.isfrom == 23|self.isfrom == 24) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (From1(self)|From2(self)) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
- (void)back {
    //来自理财：
    
    MainTabbarController *t = [[MainTabbarController alloc] initWith:22];
    //发送消息
    if (self.isfrom == 22) {//活期
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"99"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else if (self.isfrom == 23){//定期
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"0"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else if (self.isfrom == 24){//新手标
        t.isfrom = 2;
        NSNotification * notice = [NSNotification notificationWithName:JNotificationZhangHu object:self userInfo:@{@"s":@"101"}];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    self.view.window.rootViewController = t;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.pageNum == 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+0;
        [self changePage:btn];
    }else if (self.pageNum == 1){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+1;
        [self changePage:btn];
    }
}
#pragma - 创建通用UI
- (void)configUI {
    self.view.backgroundColor = RGB_gray;
    
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
      
    
}
- (UIButton *)createButtonWithTitle:(NSString *)title backImgName:(NSString *)imgName frame:(CGRect)frame titleColor:(UIColor *)color{
    UIButton *Btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitleColor:color forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    Btn.frame = frame;
    return Btn;
}



#pragma mark - 创建pageVC
- (void)initData{
    //创建数据源
    _vcArray = [NSMutableArray array];
    DetailVCSubOne *sub1 = [[DetailVCSubOne alloc]init];
    sub1.pageNum = 0;
    sub1.productId = self.productId;
    sub1.scrollNum =self.scrollNum;
    [_vcArray addObject:sub1];
    DetailVCSubOne *sub2 = [[DetailVCSubOne alloc]init];
    sub2.pageNum = 1;
    sub2.productId = self.productId;
    sub2.scrollNum =self.scrollNum;
    [_vcArray addObject:sub2];
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, JSCREEN_W, 35);
    _titleScrollView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<_vcArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(w/_vcArray.count*i, 0, w/_vcArray.count, 35);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:RGB_red forState:UIControlStateSelected];
        [btn setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
        if (i==0){
            [btn setTitle:@"产品介绍" forState:UIControlStateNormal];
        }
        if (i==1){
            [btn setTitle:@"安全保障" forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/2, 35)];
    _indicatorView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, (_indicatorView.bounds.size.height-1), w/2, 1)];
    [btn setBackgroundColor:RGB_red];
    [_indicatorView addSubview:btn];
    _indicatorView.alpha = 1;
    [_titleScrollView addSubview:_indicatorView];
    
}
- (void)configPageViewController {
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.frame =CGRectMake(0, 0, self.contetnView.frame.size.width, self.contetnView.frame.size.height);
    _pageViewController.view.backgroundColor = RGB_gray;
    [self.contetnView addSubview:_pageViewController.view];
    
    
    //找到pageViewController view的scrollview，并将其代理设为self
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)view).delegate = self;
        }
    }
}
#pragma mark - PageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //查找当前界面viewcontroller是数组中第几个
    NSInteger index = [_vcArray indexOfObject:viewController];
    
    if (index == _vcArray.count-1) {
        return nil;
    }
    //返回下一页
    return _vcArray[index+1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //返回上一页的界面
    NSInteger index = [_vcArray indexOfObject:viewController];
    //viewController也可以返回_vcArray[11]
    if (index == 0) {
        return nil;
    }
    return _vcArray[index-1];
}
//翻页结束处罚的代理方法
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            s.selected = NO;
        }
    }
    
    //获取当前页数
    UIViewController *sub = pageViewController.viewControllers[0];
    NSInteger index = [_vcArray indexOfObject:sub];
    _curPage = index;
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == index+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
        }
    }
    
}
//跳转到对应的页面
- (void)changePage:(UIButton *)btn
{
    for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            s.selected = NO;
        }
    }
    
    NSInteger jumpToPage = btn.tag - 100;
    
    [_pageViewController setViewControllers:@[_vcArray[jumpToPage]] direction:jumpToPage<_curPage animated:YES completion:^(BOOL finished) {
        _curPage = jumpToPage;
    }];
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == jumpToPage+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
        }
    }
    
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    CGFloat offSetX = scrollView.contentOffset.x;
    
    CGFloat offSetIndicatorX = (width/3)/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
    frame.origin.x = offSetIndicatorX + _curPage*width/2;
    _indicatorView.frame = frame;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    if (self.isfrom == 23|self.isfrom == 22|self.isfrom == 24) {
        [self back];
        return;
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
