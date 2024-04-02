//
//  WQAdjustCellScaleLayout.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/4/1.
//

#import "WQAdjustCellScaleLayout.h"
#import "WQAdjustCellScaleOneCell.h"

@implementation WQAdjustCellScaleLayout
@synthesize itemScale = _itemScale;
- (void)setItemScale:(CGFloat)itemScale {
    _itemScale = itemScale;
    [self invalidateLayout];
}

- (instancetype)init {
    self = [super init];

    if (self) {
        // 设置默认属性值
        self.itemSize = CGSizeMake(105, 100); // 设置默认 cell 的大小
        self.minimumLineSpacing = 10; // 设置默认行间距
        self.minimumInteritemSpacing = 10; // 设置默认列间距
        self.itemScale = 1.0; // 设置默认缩放比例
    }

    return self;
}

- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section {
    // 通过代理方法获取分区的边距
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }

    return UIEdgeInsetsZero;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向为垂直
//    Log([self insetForSectionAtIndex:0]);
}

//- (void)prepareLayout {
//    [super prepareLayout];
//
//    // 清空之前的布局属性
//    [self.itemAttributes removeAllObjects];
//
//    // 获取 sectionInsets 和 itemSize
//    UIEdgeInsets sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    CGSize itemSize = self.itemSize;
//
//    // 计算 collectionView 的宽度
//    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
//
//    // 计算每行的最大 cell 数量和行高
//    NSInteger maxCellsPerRow = (collectionViewWidth - sectionInsets.left - sectionInsets.right + self.minimumInteritemSpacing) / (itemSize.width + self.minimumInteritemSpacing);
//    CGFloat rowHeight = itemSize.height + self.minimumLineSpacing;
//
//    // 初始化当前行和当前行的 Y 偏移
//    NSInteger currentRow = 0;
//    CGFloat currentYOffset = sectionInsets.top;
//
//    // 遍历所有 cell
//    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
//    for (NSInteger i = 0; i < itemCount; i++) {
//        // 计算当前 cell 的 X 偏移
//        CGFloat currentXOffset = sectionInsets.left + (itemSize.width + self.minimumInteritemSpacing) * (i % maxCellsPerRow);
//
//        // 如果当前 cell 不在当前行，更新当前行和 Y 偏移
//        if (i % maxCellsPerRow == 0 && i != 0) {
//            currentRow++;
//            currentYOffset += rowHeight;
//        }
//
//        // 创建并设置当前 cell 的布局属性
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//
//        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        attributes.frame = CGRectMake(currentXOffset, currentYOffset, itemSize.width, itemSize.height);
//        [self.itemAttributes addObject:attributes];
//    }
//
////    // 设置 contentSize
////    CGFloat contentHeight = currentYOffset + itemSize.height + sectionInsets.bottom;
////    self.contentSize = CGSizeMake(collectionViewWidth, contentHeight);
//}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray<UICollectionViewLayoutAttributes *> *superAttributesArray = self.itemAttributes;
    NSArray<UICollectionViewLayoutAttributes *> *superAttributesArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray = [NSMutableArray array];

    Log(rect);
    Log(self.sectionInset);

    [superAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *_Nonnull attributes, NSUInteger idx, BOOL *_Nonnull stop) {
        // 先复制一份父类返回的布局属性
        UICollectionViewLayoutAttributes *modifiedAttributes = [attributes copy];

        // 通过数据源方法获取对应 indexPath 的模型数据
        // id model = [self.dataSource collectionView:self.collectionView modelForItemAtIndexPath:attributes.indexPath];

        // 在这里可以根据获取到的模型数据进行一些处理

        // 根据外部设置的缩放比例进行缩放
        CGFloat scale = self.itemScale;

        // 设置缩放比例
        modifiedAttributes.transform = CGAffineTransformMakeScale(scale, scale);

        [attributesArray addObject:modifiedAttributes];
    }];

    return attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES; // 滑动时重新布局
}

#pragma mark -
#pragma mark laze
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)itemAttributes {
    if (!_itemAttributes) {
        _itemAttributes = [NSMutableArray array];
    }

    return _itemAttributes;
}

@end
