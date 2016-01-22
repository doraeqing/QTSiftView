//
//  WLSiftView.h
//
//  Created by Lucius on 16/1/14.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSiftTabItem.h"

/**
 *  暂时没用到 =.=
 */
typedef NS_ENUM(NSUInteger,WLSiftViewType) {
    /**
     *  *.*
     */
    WLSiftViewTypeDefault = 0,
    /**
     *  -.-
     */
    WLSiftViewTypeBottom
};

@protocol WLSiftViewTypeDelegate,WLSiftViewTypeDataSource;

@interface WLSiftView : UIView
/**
 *  a delegate
 */
@property (nonatomic, weak) id <WLSiftViewTypeDelegate> delegate;
/**
 *  a datasource
 */
@property (nonatomic, weak) id <WLSiftViewTypeDataSource> dataSource;

/**
 *  刷新tab
 */
- (void)reloadData;

@end

@protocol WLSiftViewTypeDataSource <NSObject>
@optional
/**
 *  一共有多少个tab选项
 *
 *  @param siftView siftView
 *
 *  @return 总共的tab数量 默认是4个
 */
- (NSInteger)numberOfTabsInSitfView:(WLSiftView *)siftView;

/**
 *  tab的样式
 *
 *  @param siftView siftView
 *  @param index    位置
 *
 *  @return 完成了FilterSiftTabItem协议的对象
 */
- (id <WLSiftTabItem>)siftView:(WLSiftView *)siftView itemForTabAtIndex:(NSInteger)index;
/**
 *  想要展示的View
 *
 *  @param siftView siftView
 *  @param index    在哪一个index展示什么样的View
 *
 *  @return 要展示的View
 */
- (UIView *)siftView:(WLSiftView *)siftView viewForContentAtIndex:(NSInteger)index;
@end

@protocol WLSiftViewTypeDelegate <NSObject>

@optional
/**
 *  选择了哪一个tab
 *
 *  @param siftView siftView
 *  @param index    选择的位置
 */
- (void)siftView:(WLSiftView *)siftView didSelectdTabAtIndex:(NSInteger)index;
/**
 *  要展示view的高度
 *
 *  @param siftView siftView
 *  @param index    在哪一个位置
 *
 *  @return 在index位置的高度 默认高度是242
 */
- (CGFloat)siftView:(WLSiftView *)siftView heightOfContentViewAtIndex:(NSInteger)index;

@end
@interface WLSiftView (Animation)
/**
 *  展示内容View
 *
 *  @param index 在对应的位置
 */
- (void)showContentViewAtIndex:(NSInteger)index;
/**
 *  让内容View消失
 */
- (void)dismissContentView;
/**
 *  隐藏siftTab
 */
- (void)hiddenSiftTab;
/**
 *  显示siftTab
 */
- (void)showSiftTab;
/**
 *  内容View的高度
 *
 *  @param index 在哪一个位置
 *
 *  @return 内容View的高度
 */
- (CGFloat)heightOfContentAtIndex:(NSInteger)index;
@end