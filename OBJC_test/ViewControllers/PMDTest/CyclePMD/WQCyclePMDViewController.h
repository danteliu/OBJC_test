//
//  WQCyclePMDViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/16.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WQCyclePMDViewController : UIViewController<SDCycleScrollViewDelegate>
@end


@interface CyclePMDView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;/**<  外部数据源 */
@property (nonatomic, strong) NSMutableArray *titles;
@end

@interface XLCycleCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

@end
NS_ASSUME_NONNULL_END
