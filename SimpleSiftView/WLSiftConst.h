//
//  WLSiftConst.h
//  SimpleSiftView
//
//  Created by Lucius on 16/1/20.
//  Copyright © 2016年 L.Q. All rights reserved.
//
#import <UIKit/UIKit.h>

extern const CGFloat WYSiftViewTabHeight;
extern const CGFloat WYSiftViewContentHeight;
extern const CGFloat WYSiftViewNavStatusHeight;
extern const CGFloat WYSiftViewNumberOfTabs;

#define WYSV_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height  

#define WYSiftViewTabBackgroundColor WY_RGBA(46,52,59,0.97) 
#define WYSiftViewBackGroundColor   WY_RGBA(0,0,0,0.7)

#define WY_RGBA(r,g,b,a)   [UIColor colorWithRed:(float)(r/255.0f) green:(float)(g/255.0f) blue:(float)(b/255.0f) alpha:a]
