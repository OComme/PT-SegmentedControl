//
//  ViewController.m
//  PT-SegmentedControlDemo
//
//  Created by BlanBok on 2018/6/8.
//  Copyright © 2018年 OComme. All rights reserved.
//

#import "ViewController.h"
#import <PTSegmentedControl/PTSegmentedControl.h>
#import "PTSegmentViewModel.h"


@interface ViewController ()<PTSegmentedControlDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet PTSegmentedControl *view_segment;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_images;

@property (nonnull, nonatomic,strong) PTSegmentViewModel *vm_segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configure_indexView];
}

- (void)configure_indexView
{
    self.view_segment.dataSource = self.vm_segment;
    self.view_segment.delegate = self;
    
    self.scroll_images.delegate = self;
}

#pragma mark-PTSegmentedControlDelegate
- (void)segmentedControl:(PTSegmentedControl *)segmentedControl didSelectItem:(NSUInteger)index
{
    [self.scroll_images setContentOffset:CGPointMake(self.scroll_images.bounds.size.width*index, 0) animated:YES];
}
#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.bounds.size.width == 0) {
        return;
    }
    self.view_segment.animationFloat = scrollView.contentOffset.x/scrollView.bounds.size.width;
}

#pragma mark-lazyload
- (PTSegmentViewModel *)vm_segment
{
    if (_vm_segment == nil) {
        _vm_segment = [PTSegmentViewModel new];
    }
    return _vm_segment;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
