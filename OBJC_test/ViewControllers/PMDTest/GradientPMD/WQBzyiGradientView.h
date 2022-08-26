//
//  WQBzyiGradientView.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQBzyiGradientView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *titles;

-(void)loadData:(NSMutableArray *)datas;/**<  加载数据 */

@end
@interface WQBzyiGradientViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
