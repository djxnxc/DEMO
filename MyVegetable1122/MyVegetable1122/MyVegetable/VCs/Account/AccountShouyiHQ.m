//
//  AccountShouyiHQ.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountShouyiHQ.h"
#import "AccountHQSubOne.h"

@interface AccountShouyiHQ ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
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
    //AccountHQSubOne *sub1;
    BOOL scrollPage;
}
@property (weak, nonatomic) IBOutlet UIView *indView;
@property (weak, nonatomic) IBOutlet UIView *contetnView;




@end

@implementation AccountShouyiHQ

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活期收益明细";
    self.contetnView.backgroundColor = RGB_gray;
    //self.contetnView.frame = CGRectMake(0, 30+35+10, JSCREEN_W, JSCREEN_H-(30+35+10) );
    self.view.backgroundColor = RGB_gray;
    [self configUI];
    //创建子页
    [self initData];
    [self configTitleScrollView];
    [self configPageViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    scrollPage=YES;
    
    if (_isFirst == 2) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+1;
        [self changePage:btn];
    }else{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+0;
        [self changePage:btn];
    }
    //隐藏导航栏
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    //    显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
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
    CGRect f=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-80-70);;
    _vcArray = [NSMutableArray array];
   AccountHQSubOne* sub1 = [[AccountHQSubOne alloc]init];
    sub1.pageNum = 0;
    sub1.view.frame=f;
    //[self.contetnView addSubview:sub1.view];
   // [sub1 setTableViewFrame:f];
    [_vcArray addObject:sub1];
    AccountHQSubOne *sub2 = [[AccountHQSubOne alloc]init];
    sub2.pageNum = 1;
   // [sub2 setTableViewFrame:f];
    [_vcArray addObject:sub2];
    
}
- (void)configTitleScrollView {
    CGFloat w = JSCREEN_W;
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, JSCREEN_W, 35);
    _titleScrollView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(w/2*i, 0, w/2, 35);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:RGB_red forState:UIControlStateSelected];
        [btn setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
        if (i==0){
            [btn setTitle:@"近一周收益" forState:UIControlStateNormal];
        }
        if (i==1){
            [btn setTitle:@"近一个月收益" forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.bounces = NO;
    [self.indView addSubview:_titleScrollView];
    
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
//    _pageViewController.view.frame = self.contetnView.frame;
    CGFloat x =  self.contetnView.frame.origin.x;
     CGFloat y =  self.contetnView.frame.origin.y;
    CGFloat ft=JSCREEN_W;
    int move=65;
    if (iPhone6) {
        move=155;
    }else if(iPhone6P)
    {
        move=3*move;
    }else if (iPhone5)
    {
        move=100;
    }
    _pageViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, JSCREEN_H-move);
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.backgroundColor = RGB_gray;
    [self.contetnView addSubview:_pageViewController.view];
    AccountHQSubOne* ah=_vcArray[0];
    [ah setTableViewFrame:CGRectMake(0, 0,SCREEN_WIDTH, JSCREEN_H-move)];
   
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
    if (scrollPage) {
        scrollPage=NO;
    for (UIView *v in _titleScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *s = (UIButton *)v;
            s.selected = NO;
        }
    }
        UIWindow* win=[UIApplication sharedApplication].keyWindow;
        
    CGRect f=CGRectMake(0, 0, win.frame.size.width, SCREEN_HEIGHT-80-70);
    NSInteger jumpToPage = btn.tag - 100;
        if (jumpToPage==_curPage) {
            scrollPage=YES;
        }
    [_pageViewController setViewControllers:@[_vcArray[jumpToPage]] direction:jumpToPage<_curPage animated:YES completion:^(BOOL finished) {
        _curPage = jumpToPage;
        AccountHQSubOne* ah=_vcArray[jumpToPage];
        //[ah setTableViewFrame:f];
        scrollPage=YES;
    }];
    for (UIView *v in _titleScrollView.subviews) {
        if (v.tag == jumpToPage+100) {
            UIButton *s = (UIButton *)v;
            s.selected = YES;
        }
    }
    }
//    sub1.pageNum=jumpToPage;
//    [sub1 reflash];
    
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = JSCREEN_W;
    CGFloat offSetX = scrollView.contentOffset.x;
    
    CGFloat offSetIndicatorX = (width/3)/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
#warning 注意处理
    if (iPhone6) {
        if (offSetIndicatorX<20&&offSetIndicatorX>0) {
            offSetIndicatorX = 0;
        }
    }else if (iPhone6P){
        if (offSetIndicatorX<40&&offSetIndicatorX>0) {
            offSetIndicatorX = 0;
        }
    }
    
    frame.origin.x =
    offSetIndicatorX +
    _curPage*width/2;
    
    _indicatorView.frame = frame;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

