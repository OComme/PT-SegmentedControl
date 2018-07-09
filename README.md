# PT-SegmentedControl

` PTSegmentedControl` 是遵循面向协议的思想来封装的分栏控制器。

具体使用方式类似 `UITableView` 和 `UICollectionView`,通过 `delegate` 和 `dataSource` 来定制 `View`

`delegate`主要实现相应的点击方法

```Objective-C
@protocol PTSegmentedControlDelegate <NSObject>

@optional

/**
 选中某一位置
 
 @param segmentedControl 数据列表
 @param index 位置
 */
- (void)segmentedControl:(PTSegmentedControl *)segmentedControl didSelectItem:(NSUInteger)index;

@end
```

`dataSource`用来定制`View`的显示

```Objective-C
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

```


你可以使用 

`pod 'PTSegmentedControl', :git=> 'https://github.com/OComme/PT-SegmentedControl'`

将这个工具导入你的项目
