//
//  FliterSiftView.m
//  Dotec
//
//  Created by Lucius on 16/1/14.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import "WLSiftView.h"
#import "WLSiftTabViewCell.h"
#import "WLSiftConst.h"

static NSString *const kWLSiftTabViewCell  =  @"WLSiftTabViewCell";

static inline NSIndexPath *DT_IndexPathFromRow(NSInteger index){
    return [NSIndexPath indexPathForRow:index inSection:0];
}

@interface WLSiftView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *siftContent;
@property (nonatomic, strong) UIControl *backGroundView;
@property (nonatomic, weak)   UICollectionView *siftTab;
@property (nonatomic, assign) NSInteger currentShownContent;
@property (nonatomic, strong) NSMutableDictionary *contentViewData;
@end

@implementation WLSiftView {
    //位域 判断dataSource或者delegate是否实现了协议的方法
    struct {
        unsigned  numberOfTabsInSitfView : 1;
        unsigned  itemForTabAtIndex : 1;
        unsigned  viewForContentAtIndex : 1;
    }_dataSourceHas;
    struct {
        unsigned didSelectdTabAtIndex : 1;
        unsigned heightOfContentViewAtIndex : 1;
    }_delegateHas;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    self.siftContent.frame = CGRectMake(0, WYSV_SCREEN_HEIGHT , self.frame.size.width, self.frame.size.height);
    self.currentShownContent = NSIntegerMax;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.siftTab.frame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
    if (_dataSourceHas.viewForContentAtIndex) {
        NSInteger numberOfTabs = [self p_numberOfTabs];
        for (int i = 0; i < numberOfTabs; i++) {
            UIView *temp = [self.contentViewData objectForKey:@(i)]?:[_dataSource siftView:self viewForContentAtIndex:i];
            if (temp) {
                temp.frame = CGRectMake(0, 0, self.frame.size.width,[self heightOfContentAtIndex:i]);
                [self.contentViewData setObject:temp forKey:@(i)];
                [self.siftContent addSubview:temp];
            }
        }
    }
}
#pragma mark - public
- (void)reloadData {
    [self.siftTab reloadData];
}

#pragma mark - private
- (NSInteger)p_numberOfTabs {
    if (_dataSourceHas.numberOfTabsInSitfView) {
        return [_dataSource numberOfTabsInSitfView:self];
    }else{
        return WYSiftViewNumberOfTabs;
    }
}
- (UICollectionViewCell *)p_cellForItemAtIndex:(NSInteger)index {
    if (_dataSourceHas.itemForTabAtIndex) {
        [self.siftTab registerNib:[UINib nibWithNibName:@"WLSiftTabViewCell" bundle:nil] forCellWithReuseIdentifier:kWLSiftTabViewCell];
        WLSiftTabViewCell *cell = [self.siftTab dequeueReusableCellWithReuseIdentifier:kWLSiftTabViewCell forIndexPath:DT_IndexPathFromRow(index)];
        if (_dataSourceHas.itemForTabAtIndex) {
            id<WLSiftTabItem>obj = [_dataSource siftView:self itemForTabAtIndex:index];
            if ([obj isSelected]) {
                cell.siftIcon.image = [obj selectImage];
                cell.siftTitle.textColor = [obj selectedTitleColor];
            }else{
                cell.siftIcon.image = [obj defaultImage];
                cell.siftTitle.textColor = [obj defaultTitleColor];
            }
            cell.siftTitle.text = [obj title];
        }
        return cell;
    }
    return [UICollectionViewCell new];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self p_numberOfTabs];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self p_cellForItemAtIndex:indexPath.row];
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentShownContent == indexPath.row) {
        [self dismissContentView];
    }else{
        [self showContentViewAtIndex:indexPath.row];
    }
    
    if (_delegateHas.didSelectdTabAtIndex) {
        [_delegate siftView:self didSelectdTabAtIndex:indexPath.row];
    }
    [self.siftTab reloadItemsAtIndexPaths:@[indexPath]];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = self.siftTab.frame.size.width / [self p_numberOfTabs];
    CGSize temp= CGSizeMake(width, self.siftTab.frame.size.height);
    
    return temp;
}
#pragma mark - accessor
- (UICollectionView *)siftTab {
    if (!_siftTab) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *tempCv = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
        tempCv.dataSource = self;
        tempCv.delegate = self;
        tempCv.backgroundColor = WYSiftViewTabBackgroundColor;
        [self addSubview:_siftTab = tempCv];
    }
    return _siftTab;
}
- (UIView *)siftContent {
    if (!_siftContent) {
        _siftContent = [[UIView alloc] initWithFrame:self.frame];
        _siftContent.autoresizesSubviews = NO;
        _siftContent.backgroundColor = [UIColor clearColor];
    }
    return _siftContent;
}
- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIControl alloc] init];
        _backGroundView.backgroundColor = WYSiftViewBackGroundColor;
        [_backGroundView addTarget:self action:@selector(dismissContentView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGroundView;
}
- (void)setDataSource:(id<WLSiftViewTypeDataSource>)dataSource {
    _dataSource = dataSource;
    _dataSourceHas.numberOfTabsInSitfView = [_dataSource respondsToSelector:@selector(numberOfTabsInSitfView:)];
    _dataSourceHas.itemForTabAtIndex = [_dataSource respondsToSelector:@selector(siftView:itemForTabAtIndex:)];
    _dataSourceHas.viewForContentAtIndex = [_dataSource respondsToSelector:@selector(siftView:viewForContentAtIndex:)];
}
- (void)setDelegate:(id<WLSiftViewTypeDelegate>)delegate {
    _delegate = delegate;
    _delegateHas.didSelectdTabAtIndex = [_delegate respondsToSelector:@selector(siftView:didSelectdTabAtIndex:)];
    _delegateHas.heightOfContentViewAtIndex = [_delegate respondsToSelector:@selector(siftView:heightOfContentViewAtIndex:)];
}
- (NSMutableDictionary *)contentViewData {
    if (!_contentViewData) {
        _contentViewData = [NSMutableDictionary dictionary];
    }
    return _contentViewData;
}
@end

@implementation WLSiftView (Animation)

- (void)hiddenSiftTab{
    
    [UIView animateWithDuration:WYSiftViewDismissAnimateDefaultDuration animations:^{
        self.frame = CGRectMake(self.frame.origin.x,WYSV_SCREEN_HEIGHT - WYSiftViewNavStatusHeight, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
    }];
}
- (void)showSiftTab {
    [UIView animateWithDuration:WYSiftViewDismissAnimateDefaultDuration animations:^{
        self.frame = CGRectMake(self.frame.origin.x,WYSV_SCREEN_HEIGHT - self.frame.size.height - WYSiftViewNavStatusHeight, self.frame.size.width, self.frame.size.height);
    
    } completion:^(BOOL finished) {
    }];
}
- (void)insertSubview {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.siftContent.frame = CGRectMake(window.frame.origin.x, window.frame.size.height, window.frame.size.width, window.frame.size.height);
    self.backGroundView.frame = window.bounds;
    [window insertSubview:self.siftContent aboveSubview:self.siftTab];
    [window insertSubview:self.backGroundView belowSubview:self.siftContent];
    
}
- (CGFloat)heightOfContentAtIndex:(NSInteger)index {
    if (_delegateHas.heightOfContentViewAtIndex) {
        return [_delegate siftView:self heightOfContentViewAtIndex:index];
    }else{
        return WYSiftViewContentHeight;
    }
}
- (void)showContentViewAtIndex:(NSInteger)index {
    CGFloat height = [self heightOfContentAtIndex:index];
    self.currentShownContent = index;
    [self insertSubview];
    [self.contentViewData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIView * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
    UIView *temp = [self.contentViewData objectForKey:@(index)];
    temp.hidden = NO;
    temp.frame = CGRectMake(0, 0, self.frame.size.width,WYSV_SCREEN_HEIGHT);
    [UIView animateWithDuration:WYSiftViewShowAnimateDuration
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backGroundView.alpha = 1.0;
                         self.siftContent.frame = CGRectMake(self.frame.origin.x, WYSV_SCREEN_HEIGHT- height, self.frame.size.width, WYSV_SCREEN_HEIGHT);
                     } completion:^(BOOL finished) {
                         temp.frame = CGRectMake(0, 0, self.frame.size.width,height);
                     }];
}
- (void)dismissContentView {
    self.currentShownContent = NSIntegerMax;
    [UIView animateWithDuration:WYSiftViewDismissAnimateDefaultDuration
                     animations:^{
                         self.siftContent.frame = CGRectMake(self.siftContent.frame.origin.x, WYSV_SCREEN_HEIGHT,self.siftContent.frame.size.width, self.siftContent.frame.size.height);;
                         self.backGroundView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.siftContent removeFromSuperview];
                         [self.backGroundView removeFromSuperview];
                     }];
}
@end