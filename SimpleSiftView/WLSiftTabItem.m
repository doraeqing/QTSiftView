
//
//  FilterSiftButton.m
//  Dotec
//
//  Created by Lucius on 16/1/14.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import "WLSiftTabItem.h"

@implementation WLSiftTabItem

@synthesize title = _title;
@synthesize defaultTitleColor = _defaultTitleColor;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize defaultImage = _defaultImage;
@synthesize selected = _selected;
@synthesize selectImage = _selectImage;

- (instancetype)initWithTitle:(NSString *)title
            defaultTitleColor:(UIColor *)defaultColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                 defaultImage:(UIImage *)defaultImage
                  selectImage:(UIImage *)selectImage
                     selected:(BOOL)selected{
    
    if (self = [super init]) {
        self.title = title;
        self.defaultTitleColor = defaultColor;
        self.selectedTitleColor = selectedTitleColor;
        self.defaultImage = defaultImage;
        self.selected = selected;
        self.selectImage = selectImage;
    }
    return self;
}

@end
