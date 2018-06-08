//
//  PTSegmentedControl.h
//  PT-SegmentedControlDemo
//
//  Created by BlanBok on 2018/6/8.
//  Copyright © 2018年 OComme. All rights reserved.
//
//  分栏控制按钮

#import <UIKit/UIKit.h>
@class PTSegmentedControl;

@protocol PTSegmentedControlDelegate <NSObject>

@optional

/**
 选中某一位置
 
 @param segmentedControl 数据列表
 @param index 位置
 */
- (void)segmentedControl:(PTSegmentedControl *)segmentedControl didSelectItem:(NSUInteger)index;

@end

@protocol PTSegmentedControlDataSource <NSObject>

/**
 item数量
 
 @param segmentedControl 数据列表
 @return item数量
 */
- (NSUInteger)numberOfSectionsInSegmentedControl:(PTSegmentedControl *)segmentedControl;

/**
 获取指定位置的cell
 
 @param segmentedControl 数据列表
 @param index 位置
 @return cell
 */
- (__kindof UIControl *)segmentedControl:(PTSegmentedControl *)segmentedControl cellForItem:(NSUInteger)index;

/**
 某一位置的按钮尺寸
 
 @param segmentedControl 数据列表
 @param index 位置
 @return 尺寸
 */
- (CGSize)segmentedControl:(PTSegmentedControl *)segmentedControl sizeForItem:(NSUInteger)index;

@optional

/**
 线条
 */
- (UIView *)lineViewInSegmentedControl:(PTSegmentedControl *)segmentedControl;

/**
 线条尺寸
 */
- (CGSize)sizeOfLineInSegmentedControl:(PTSegmentedControl *)segmentedControl;

@end

@interface PTSegmentedControl : UIView

/**
 逻辑代理
 */
@property (nullable,nonatomic,weak) id <PTSegmentedControlDelegate> delegate;

/**
 数据代理
 */
@property (nullable,nonatomic,weak) id <PTSegmentedControlDataSource> dataSource;

/**
 动画进度
 */
@property (nonatomic,assign) CGFloat animationFloat;

/**
 刷新数据
 */
- (void)reloadData;

@end
