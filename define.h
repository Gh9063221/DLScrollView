//
//  define.h
//  DLScrollView
//
//  Created by zht on 13-7-2.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#ifndef DLScrollView_define_h
#define DLScrollView_define_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT 20
#define NAV_HEIGHT 44
#define TABBAR_HEIGHT 49

//CGRectChange
#define CGRectChangeOriginX(_rect_, _originX_) CGRectMake(_originX_, _rect_.origin.y, _rect_.size.width, _rect_.size.height)
#define CGRectChangeOriginY(_rect_, _originY_) CGRectMake(_rect_.origin.x, _originY_, _rect_.size.width, _rect_.size.height)
#define CGRectChangeSizeX(_rect_, _sizeX_)  CGRectMake(_rect_.origin.x, _rect_.origin.y, _sizeX_, _rect_.size.height)
#define CGRectChangeSizeY(_rect_, _sizeY_)  CGRectMake(_rect_.origin.x, _rect_.origin.y, _rect_.size.width, _sizeY_)
#define CGRectChangeOrigin(_rect_, _origin_)  CGRectMake(_origin_.x, _origin_.y, _rect_.size.x, _rect_.size.y)
#define CGRectChangeSize(_rect_, _size_)   CGRectMake(_rect_.origin.x, _rect_.origin.y, _size_.x, _size_.y)
#define CGRectMakeWithPoint(_origin_, _size_)  CGRectMake(_origin_.x, _origin_.y, _size_.width, _size_.height)

#define CLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//init method with local file
#define DATA_WITH_FILE(_filename_, _filetype_) [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_filename_ ofType:_filetype_]]
#define ARRAY_WITH_FILE(_filename_, _filetype_) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_filename_ ofType:_filetype_]]
#define MARRAY_WITH_FILE(_filename_, _filetype_) [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_filename_ ofType:_filetype_]]]
#define IMAGE_WITH_FILE(_filename_, _filetype_) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_filename_ ofType:_filetype_]]
#define IMAGEVIEW_WITH_FILE(_filename_, _filetype_) [[[UIImageView alloc] initWithImage:IMAGE_WITH_FILE(_filename_, _filetype_)] autorelease]

#endif
