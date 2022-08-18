//
//  DantePMDViewController.h
//  OBJC_test
//
//  Created by liu dante on 2022/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQPMDViewController : UIViewController<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray * itemViews;/**<  <#属性注释#> */
@property (nonatomic, strong) BaseHScrollview * hScrollView;/**<  <#属性注释#> */
@property (nonatomic, strong) CABasicAnimation * scrollAnimation;/**<  <#属性注释#> */


@end

NS_ASSUME_NONNULL_END
