//
//  WQAdjustCellScaleLayout.h
//  OBJC_test
//
//  Created by maggie.qiu on 2024/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQAdjustCellScaleLayout : UICollectionViewFlowLayout
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemAttributes;//存储各个cell的属性

@property (nonatomic, assign) CGFloat itemScale; // 缩放比例
@end

NS_ASSUME_NONNULL_END
