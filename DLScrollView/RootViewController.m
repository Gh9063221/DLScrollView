//
//  RootViewController.m
//  DLScrollView
//
//  Created by zht on 13-7-2.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import "RootViewController.h"
#import "define.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *arr = @[@"bg1.png", @"bg2.png", @"bg3.png",
                     @"http://g.hiphotos.baidu.com/album/w%3D2048/sign=873a1f715d6034a829e2bf81ff2b4854/71cf3bc79f3df8dccf1f19e1cc11728b4710289b.jpg"];
    self.scrollView = [DLScrollView scrollViewWithFrame:self.view.bounds AndImages:arr];
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor greenColor];
    
//    for (NSString *str in self.scrollView.stringArr) {
//        CLog(@"%@", str);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
