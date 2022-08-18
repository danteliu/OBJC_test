//
//  WQBYCyclePMDViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQBYCyclePMDViewController : UIViewController

@end
@interface BYCyclePMDView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *titles;

-(void)loadData:(NSMutableArray *)datas;/**<  加载数据 */
@end

@interface BYXLCycleCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@end
NS_ASSUME_NONNULL_END
