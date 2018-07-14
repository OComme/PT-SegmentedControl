//
//  PTSegmentViewModel.m
//  PT-SegmentedControlDemo
//
//  Created by Mac on 2018/7/14.
//  Copyright © 2018年 OComme. All rights reserved.
//

#import "PTSegmentViewModel.h"

@implementation PTSegmentViewModel

- (CGSize)sizeOfLineInSegmentedControl:(PTSegmentedControl *)segmentedControl
{
    return CGSizeMake(8, 3);
}

- (UIView *)lineViewInSegmentedControl:(PTSegmentedControl *)segmentedControl
{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:255/255.0 green:120/255.0 blue:0 alpha:1];
    lineView.layer.cornerRadius = 1.5;
    return lineView;
}

- (NSUInteger)numberOfSectionsInSegmentedControl:(PTSegmentedControl *)segmentedControl {
    return 2;
}

- (__kindof UIControl *)segmentedControl:(PTSegmentedControl *)segmentedControl cellForItem:(NSUInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@[@"全部",@"收藏"][index] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:120/255.0 blue:0 alpha:1] forState:UIControlStateSelected];
    return btn;
}

- (CGSize)segmentedControl:(PTSegmentedControl *)segmentedControl sizeForItem:(NSUInteger)index {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2.0, 40);
}

@end
