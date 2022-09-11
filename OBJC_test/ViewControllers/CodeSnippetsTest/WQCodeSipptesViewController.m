//
//  WQCodeSipptesViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/12.
//

#import "WQCodeSipptesViewController.h"

@interface WQCodeSipptesViewController ()
@property (nonatomic, strong) UICollectionView *collectionViewTest; /**<  <#属性注释#> */

@end

@implementation WQCodeSipptesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializationNavigation];
    [self InitializationData];
    [self InitializeView];
}

- (void)InitializationNavigation {/**<  初始化导航栏 */
}

- (void)InitializationData {/**<  初始化数据 */
}

- (void)InitializeView {/**<  初始化视图 */
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"自动横布局视图";
    
}

@end
