//
//  BankCardViewController.m
//  yoyo
//
//  Created by 辛忠志 on 2017/5/25.
//  Copyright © 2017年 辛忠志. All rights reserved.
//


#import "CustomUICollectionViewLayout.h"


@interface CustomUICollectionViewLayout ()
@property (nonatomic, assign) CGFloat previousOffset;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation CustomUICollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    //每个section的inset，用来设定最左和最右item距离边界的距离，此处设置在中间
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) /2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}
/*第一次加载layout、刷新layout、以及- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;这个方法返回yes时，会调用。这是苹果官方的说明The collection view calls -prepareLayout once at its first layout as the first message to the layout instance. The collection view calls -prepareLayout again after layout is invalidated and before requerying the layout information. Subclasses should always call super if they override。实现该方法后应该调用［super prepareLayout］保证初始化正确。该方法用来准备一些布局所需要的信息。该方法和init方法相似，但该方法可能会被调用多次，所以一些不固定的计算（比如该计算和collectionView的尺寸相关），最好放在这里，以保证collectionView发生变化时，自定义CollectionView能做出正确的反应。*/
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
/*该方法用来返回rect范围内的 cell supplementary 以及 decoration的布局属性layoutAttributes（这里保存着她们的尺寸，位置，indexPath等等），如果你的布局都在一个屏幕内 活着 没有复杂的计算，我觉得这里可以返回全部的属性数组，如果涉及到复杂计算，应该进行判断，返回区域内的属性数组，有时候为了方便直接返回了全部的属性数组，不影响布局但可能会影响性能（如果你的item一屏幕显示不完，那么这个方法会调用多次，当所有的item都加载完毕后，在滑动collectionView时不会调用该方法的）。    */
//cell缩放的设置
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //取出父类算出的布局属性
    //不能直接修改需要copy
    NSArray * original = [super layoutAttributesForElementsInRect:rect];
    NSArray * attsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    //    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    
    //collectionView中心点的值
    //屏幕中心点对应于collectionView中content位置
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    //cell中的item一个个取出来进行更改
    for (UICollectionViewLayoutAttributes *atts in attsArray) {
        // cell的中心点x 和 屏幕中心点 的距离
        CGFloat space = ABS(atts.center.x - centerX);
        CGFloat scale = 1 - (space/self.collectionView.frame.size.width/5);
        atts.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attsArray;
}

/*(CGPoint)velocity 这个方法简单理解可以当作是用来设置collectionView的偏移量的，计算当前屏幕哪个item中心点距离屏幕中心点近，就将该item拉到中心去。*/
//设置滑动停止时的collectionView的位置
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;//最终要停下来的X
    rect.size = self.collectionView.frame.size;
    
    //获得计算好的属性
    NSArray * original = [super layoutAttributesForElementsInRect:rect];
    NSArray * attsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    //计算collection中心点X
    //视图中心点相对于collectionView的content起始点的位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attsArray) {
        //找到距离视图中心点最近的cell，并将minSpace值置为两者之间的距离
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;        //各个不同的cell与显示中心点的距离
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}
@end
