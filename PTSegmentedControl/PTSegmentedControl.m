//
//  PTSegmentedControl.m
//  PT-SegmentedControlDemo
//
//  Created by BlanBok on 2018/6/8.
//  Copyright © 2018年 OComme. All rights reserved.
//

#import "PTSegmentedControl.h"
#import "Masonry.h"

@interface PTSegmentedControl ()
{
    UIControl *_tempItem;//当前选中 item
}

/**
 存放item 的容器
 */
@property (nonnull,nonatomic,strong) UIScrollView *contentView;

/**
 标识图标
 */
@property (nullable,nonatomic,strong) UIView *view_sign;

/**
 item 集合
 */
@property (nonnull,nonatomic,strong) NSMutableArray *feedEntity_items;


@end

@implementation PTSegmentedControl

- (void)reloadData
{
//    NSAssert(self.delegate, @"PTSegmentedControl 必需设置 delegate 对象");
    NSAssert(self.dataSource, @"PTSegmentedControl 必需设置 dataSource 对象");
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
    
    if ([self.dataSource respondsToSelector:@selector(lineViewInSegmentedControl:)]) {
        self.view_sign = [self.dataSource lineViewInSegmentedControl:self];
    }else{
        self.view_sign = nil;
    }
    
    NSUInteger number = [self.dataSource numberOfSectionsInSegmentedControl:self];
    
    UIView *tempView;
    for (NSUInteger idx = 0; idx < number; idx ++) {
        UIControl *item = [self.dataSource segmentedControl:self cellForItem:idx];
        item.tag = idx + 1;
        [item addTarget:self action:@selector(event_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:item];
        
        CGSize itemSize = [self.dataSource segmentedControl:self sizeForItem:idx];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(itemSize);
            make.top.bottom.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            if (tempView == nil) {
                make.left.mas_equalTo(0);
            }else{
                make.left.equalTo(tempView.mas_right);
            }
            if (idx == number - 1) {
                make.right.mas_equalTo(0);
            }
        }];
        
        tempView = item;
        if (idx == 0) {
            item.selected = YES;
            _tempItem = item;
            
            CGSize lineSize;
            if ([self.dataSource respondsToSelector:@selector(sizeOfLineInSegmentedControl:)]) {
                lineSize = [self.dataSource sizeOfLineInSegmentedControl:self];
            }else{
                lineSize = CGSizeMake(itemSize.width, 1);
            }
            
            if (self.view_sign == nil) {
                continue;
            }
            [self.contentView addSubview:self.view_sign];
            [self.view_sign mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(item.mas_centerX);
                make.top.equalTo(item.mas_bottom).offset(-lineSize.height);
                make.size.mas_equalTo(lineSize);
            }];
        }
    }
    
}

#pragma mark-event
- (void)event_clickBtn:(UIControl*)sender
{
    if ([self.delegate respondsToSelector:@selector(segmentedControl:didSelectItem:)]) {
        [self.delegate segmentedControl:self didSelectItem:(sender.tag - 1)];
    }
    
    [self event_selectItem:sender];
}

- (void)setAnimationFloat:(CGFloat)animationFloat
{
    NSUInteger maxNumber = [self.dataSource numberOfSectionsInSegmentedControl:self];
    if (maxNumber < 2) {
        return;
    }
    NSInteger index = floor(animationFloat + 0.5)+1;
    index = (index < 0)?0:index;
    index = (index > (maxNumber+1))?(maxNumber + 1):index;
    [self event_selectItem:[self.contentView viewWithTag:index]];
    
    if (self.view_sign == nil) {
        return;
    }
    CGFloat itemSpace = fabs([self.contentView viewWithTag:2].center.x - [self.contentView viewWithTag:1].center.x);
    CGFloat offsetX = animationFloat * itemSpace;
    
    CGFloat changeOffset = fabs((animationFloat * 100 - self.view_sign.transform.tx*100));
    if (changeOffset  >= 100) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view_sign.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, offsetX, 0);
        }];
        return;
    }
    self.view_sign.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, offsetX, 0);
}

- (void)event_selectItem:(UIControl*)sender
{
    if (sender.tag <= 0 || sender.tag > [self.dataSource numberOfSectionsInSegmentedControl:self] + 1) {
        return;
    }
    if (_tempItem.tag == sender.tag) {
        return;
    }
    _tempItem.selected = NO;
    sender.selected = YES;
    _tempItem = sender;
}

#pragma mark-subView
- (void)add_contentView
{
    _contentView = [UIScrollView new];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark-set
- (void)setDataSource:(id<PTSegmentedControlDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

#pragma mark-lazyload
- (NSMutableArray *)feedEntity_items
{
    if (_feedEntity_items == nil) {
        _feedEntity_items = [NSMutableArray new];
    }
    return _feedEntity_items;
}

- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        [self add_contentView];
    }
    return _contentView;
}

@end
