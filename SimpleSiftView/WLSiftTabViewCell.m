//
//  FilterSiftViewCell.m
//  Dotec
//
//  Created by Lucius on 16/1/14.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import "WLSiftTabViewCell.h"
#import "WLSiftConst.h"

@implementation WLSiftTabViewCell

- (void)awakeFromNib {
    _siftIcon.contentMode = UIViewContentModeScaleAspectFit;
    _siftIcon.translatesAutoresizingMaskIntoConstraints = NO;
    _siftTitle.font = [UIFont systemFontOfSize:13.];
    _siftTitle.textColor = WY_RGBA(156, 157, 158, 1);
    _siftTitle.translatesAutoresizingMaskIntoConstraints = NO;
}
@end
