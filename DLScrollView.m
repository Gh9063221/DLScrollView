//
//  DLScrollView.m
//  DLScrollView
//
//  Created by zht on 13-7-2.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#define PAGECONTROL_WIDTH 100
#define PAGECONTROL_HEIGHT 40
#define IMAGE_TAG_BASE 10000

#import "DLScrollView.h"
#import "define.h"
#import "EGOImageView.h"

@implementation DLScrollView

- (void)dealloc {
    [_stringArr release];
    [_pageControl release];
    [_imgArr release];
    [_scrollView release];
    [super dealloc];
}

- (DLScrollView *)initWithFrame:(CGRect)frame AndImages:(NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        //init the scrollView
        self.scrollView = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        self.currentpage = 1;
        self.autoScroll = YES;
        [self setAutoScrollInterval:3.0];
        [self addSubview:self.scrollView];
        [self setScrollViewImages:arr];
        
        if (self.autoScroll == YES) {
            timer = [NSTimer scheduledTimerWithTimeInterval:autoScrollInterval target:self selector:@selector(runScroll) userInfo:nil repeats:YES];
        }
    }
    return self;
}

+ (DLScrollView *)scrollViewWithFrame:(CGRect)frame AndImages:(NSArray *)arr {
    return [[[DLScrollView alloc] initWithFrame:frame AndImages:arr] autorelease];
}

- (void)setScrollViewImages:(NSArray *)arr {
    //1 + (2 to n-1) + n
    NSString *oldLast = [arr lastObject];
    NSString *oldFirst = [arr objectAtIndex:0];
    NSString *newFirst = [NSString stringWithString:oldLast];
    NSString *newLast = [NSString stringWithString:oldFirst];
    //n(add) + 1 + (2 to n-1) + n + 1(add) 
    self.stringArr = [NSMutableArray arrayWithArray:arr];
    [self.stringArr insertObject:newFirst atIndex:0];
    [self.stringArr addObject:newLast];
    
    int imgViewCount = self.stringArr.count;
    self.imgArr = [NSMutableArray arrayWithCapacity:imgViewCount];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imgViewCount,
                                             self.scrollView.frame.size.height);
    for (int i = 0; i < imgViewCount; i++) {
        if ([self.stringArr[i] hasPrefix:@"http://"]) {
            EGOImageView *imgView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"home_default_bg.png"]];
            [imgView setImageURL:[NSURL URLWithString:self.stringArr[i]]];
            [self.imgArr insertObject:imgView atIndex:i];
            [imgView release];
        }
        else {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.stringArr[i]]];
            [self.imgArr insertObject:imgView atIndex:i];
            [imgView release];
        }
        [self.imgArr[i] setFrame:CGRectChangeOriginX(self.scrollView.frame, self.scrollView.frame.size.width * i)];
        [self.imgArr[i] setUserInteractionEnabled:YES];
        [self.imgArr[i] setTag:IMAGE_TAG_BASE + i];
        [self.scrollView addSubview:self.imgArr[i]];
        CLog(@"%@", self.imgArr[i]);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedAtIndex:)];
        [self.imgArr[i] addGestureRecognizer:tap];
    }
    
    self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - PAGECONTROL_WIDTH)/2, self.scrollView.bounds.size.height - PAGECONTROL_HEIGHT, PAGECONTROL_WIDTH, PAGECONTROL_HEIGHT)] autorelease];
    self.pageControl.numberOfPages = self.imgArr.count - 2;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
}
- (void)setAutoScrollInterval:(float)interval {
    autoScrollInterval = interval;
}
- (void)runScroll {
    CGPoint nextOrigin = CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width,
                                     self.scrollView.contentOffset.y);
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:nextOrigin animated:NO];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //imageViews:n(add) + 1 + (2 to n-1) + n + 1(add)
    //if scroll to the n(add), goto the n
    if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * (self.imgArr.count-2), 0);
    }
    //if scroll to the 1(add), goto the 1
    else if (self.scrollView.contentOffset.x == self.scrollView.frame.size.width * (self.imgArr.count-1)) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width - 1;
}
#pragma mark - image pressed method
- (void)pressedAtIndex:(UITapGestureRecognizer *)sender {
    CLog(@"%d", sender.view.tag - IMAGE_TAG_BASE);
    [timer invalidate];
    timer = nil;
}
#pragma mark - deal with touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { CLog(@"1");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {}
@end
