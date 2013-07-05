//
//  DLScrollView.h
//  DLScrollView
//
//  Created by zht on 13-7-2.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLScrollViewDelegate <NSObject>

- (void)scrollViewPressedAtIndex:(NSInteger)index;

@end

@interface DLScrollView : UIView <UIScrollViewDelegate>
{
    float autoScrollInterval;//default is 3
    NSTimer *timer;
}

@property (retain, nonatomic) NSMutableArray *stringArr;
@property (retain, nonatomic) NSMutableArray *imgArr;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger currentpage;
@property (retain, nonatomic) UIPageControl *pageControl;
@property (assign, nonatomic) BOOL autoScroll;//是否自动滚动,默认为YES;

+ (DLScrollView *)scrollViewWithFrame:(CGRect)frame AndImages:(NSArray *)arr;

- (void)setScrollViewImages:(NSArray *)arr;
- (void)setAutoScrollInterval:(float)interval;

@end
