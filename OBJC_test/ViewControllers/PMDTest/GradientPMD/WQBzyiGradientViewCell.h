//
//  WQBzyiGradientViewCell.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQBzyiGradientViewCell : UICollectionViewCell
@property (nonatomic, readonly, copy) void (^addModel)(id res);/**<  添加数据 */
@end

NS_ASSUME_NONNULL_END
