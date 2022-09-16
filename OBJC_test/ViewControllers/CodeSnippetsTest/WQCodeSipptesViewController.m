//
//  WQCodeSipptesViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/12.
//

#import "WQCodeSipptesViewController.h"

@interface WQCodeSipptesViewController ()
@property (nonatomic, strong) UIView *viewLine; /**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <UIView *> *arrayViews;/**<  <#属性注释#> */
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
    self.title = @"Code Snippet";
    self.viewLine.addTo(self.view);

    [self.arrayViews enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {/**<  横向等宽布局 */
        [self.view addSubview:obj];

        UIView *oldView = idx == 0 ? self.arrayViews.firstObject : self.arrayViews[idx - 1];

        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.offset(0);
            }];
        } else if (idx == self.arrayViews.count - 1) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.offset(0);
                make.width.equalTo(oldView.mas_width);

                make.left.equalTo(oldView.mas_right).offset(0);
            }];
        } else {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.offset(0);
                make.width.equalTo(oldView.mas_width);
                make.left.equalTo(oldView.mas_right).offset(0);
            }];
            oldView = obj;
        }
    }];
}

- (id)arrayViews {
    if (!_arrayViews) {
        _arrayViews = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            [obj addObject:({
                UIView *v = [[UIView alloc] init];
                v.bgColor(@"random");
                v;
            })];
            [obj addObject:({
                UIView *v = [[UIView alloc] init];
                v.bgColor(@"red");
                v;
            })];
            [obj addObject:({
                UIView *v = [[UIView alloc] init];
                v.bgColor(@"random");
                v;
            })];

            obj;
        });
    }

    return _arrayViews;
}

- (UIView *)viewLine {
    if (!_viewLine) {
        _viewLine = ({
            UIView *obj = [[UIView alloc] init];
            obj.backgroundColor = UIColor.redColor;
            obj;
        });
    }

    return _viewLine;
}

@end
