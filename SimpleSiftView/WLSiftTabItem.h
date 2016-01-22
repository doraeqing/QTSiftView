//
//  FliterSiftView.h
//  Dotec
//
//  Created by Lucius on 16/1/14.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLSiftTabItem <NSObject>

@property (nonatomic, copy) NSString *title;        
@property (nonatomic, strong) UIColor *defaultTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, assign,getter=isSelected) BOOL selected;

@end

@interface WLSiftTabItem : NSObject<WLSiftTabItem>

- (instancetype)initWithTitle:(NSString *)title
            defaultTitleColor:(UIColor *)defaultColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                 defaultImage:(UIImage *)defaultImage
                  selectImage:(UIImage *)selectImage
                     selected:(BOOL)selected;

@end


