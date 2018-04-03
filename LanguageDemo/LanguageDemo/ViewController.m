//
//  ViewController.m
//  LanguageDemo
//
//  Created by 12 on 2018/1/24.
//  Copyright © 2018年 Sino. All rights reserved.
//

#import "ViewController.h"
#import "FGLanguageTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    label.text =FGGetStringWithKeyFromTable(@"语言",@"Localizable");
    [self.view addSubview: label];
    self.labe.text = FGGetStringWithKeyFromTable(@"4hg-nu-ZXY.text",@"ViewController");
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)changeBtnClick:(id)sender {
    [[FGLanguageTool sharedInstance] changeNowLanguage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
