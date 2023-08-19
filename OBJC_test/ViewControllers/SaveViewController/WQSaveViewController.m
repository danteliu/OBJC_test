//
//  WQSaveViewController.m
//  OBJC_test
//
//  Created by maggie.qiu on 2023/8/18.
//

#import <Photos/Photos.h>
#import "WQSaveViewController.h"

@interface WQSaveViewController ()

@end

@implementation WQSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initData];
    [self initView];
}

- (void)initNavigation {/**<  初始化导航栏 */
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
}

- (void)initData {/**<  初始化数据 */
}

- (void)initView {/**<  初始化视图 */
    self.view.bgColor(@"white");
    
    NSArray *setDicts = @[
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期一";
            m.des = @"打卡今天，超越昨天";
            m.url = @"https://images.unsplash.com/photo-1691866068948-fd8869ef4094?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期二";
            m.des = @"梦想不打烊，打卡努力的足迹";
            m.url = @"https://images.unsplash.com/photo-1686256282146-46dd71827a36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期三";
            m.des = @"每一次打卡，都是向梦想更近一步";
            m.url = @"https://images.unsplash.com/photo-1688643188950-dcc91eea00de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期四";
            m.des = @"猜猜今天会遇到什么幸福的事";
            m.url = @"https://images.unsplash.com/photo-1691465451955-462470475a25?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期五";
            m.des = @"每一次打卡都是向成功迈进的脚步";
            m.url = @"https://images.unsplash.com/photo-1675725399060-b638b1c15b50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期六";
            m.des = @"持习以恒，滴石以穿";
            m.url = @"https://images.unsplash.com/photo-1691059283474-74660edb314c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80";
            m;
        }),
        ({
            WQQQSavePicModel *m = [WQQQSavePicModel new];
            m.weekday = @"星期天";
            m.des = @"祝您，今晚睡个好觉";
            m.url = @"https://images.unsplash.com/photo-1687120327990-058e7a62d525?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80";
            m;
        }),
    ];
    
    CGFloat whPcent = 112.0 / 558.0;// 设置宽高比为 558:112
    
    
    WQQQSavePicture *day_one = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 0;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        
        obj;
    });
    
    [day_one mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_one.mas_width).multipliedBy(whPcent);
        make.top.equalTo(self.view.mas_top).offset(5);
    }];
    WQQQSavePicture *day_two = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 1;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_two mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_two.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_one.mas_bottom).offset(5);
    }];
    
    WQQQSavePicture *day_thr = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 2;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_thr mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_two.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_two.mas_bottom).offset(5);
    }];
    
    WQQQSavePicture *day_four = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 3;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_four mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_thr.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_thr.mas_bottom).offset(5);
    }];
    
    WQQQSavePicture *day_five = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 4;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_five mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_four.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_four.mas_bottom).offset(5);
    }];
    
    WQQQSavePicture *day_six = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 5;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_six mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_five.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_five.mas_bottom).offset(5);
    }];
    
    WQQQSavePicture *day_seven = ({
        WQQQSavePicture *obj = [[WQQQSavePicture alloc] init];
        obj.addTo(self.view);
        NSInteger setIndex = 6;
        [obj setSaveSettingsForDict:setDicts[setIndex]];
        obj;
    });
    
    [day_seven mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@160);         // 可以根据需要设置宽度
        make.left.right.offset(0);
        make.height.equalTo(day_six.mas_width).multipliedBy(whPcent);
        make.top.equalTo(day_six.mas_bottom).offset(5);
    }];
}

@end

@interface WQQQSavePicture ()
@property (nonatomic, strong) UIView *viewCenter;/**<  <#属性注释#> */
@end

@implementation WQQQSavePicture
#pragma mark -
#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark private method
/// UI 初始化
- (void)setupUI {
    self.imageViewBg.addTo(self);
    
    self.labelTitleBg.addTo(self.imageViewBg);
    self.labelDesBg.addTo(self.imageViewBg);
    
    self.viewCenter.addTo(self.imageViewBg);
    //    self.viewCenter.bgColor(@"random");
    
    self.labelTitle.addTo(self.viewCenter);
    self.labelDes.addTo(self.viewCenter);
    
    [self.imageViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.offset(0);
        //        make.left.right.mas_greaterThanOrEqualTo(self.viewCenter);
    }];
    
    [self.labelDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.labelTitle.mas_bottom).offset(5);
        make.bottom.offset(0);
    }];
    
    [self.labelTitleBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.labelTitle).offset(0);
        make.left.equalTo(self.labelTitle.mas_left).offset(-3);
        make.right.equalTo(self.labelTitle.mas_right).offset(3);
    }];
    
    [self.labelDesBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.labelDes).offset(0);
        make.left.equalTo(self.labelDes.mas_left).offset(-3);
        make.right.equalTo(self.labelDes.mas_right).offset(3);
    }];
}

#pragma mark -
#pragma mark public method
/// 保存图片到相册
/// - Parameter view: 保存的视图
- (void)saveViewAsImageToAlbum:(UIView *)view {
    // 将视图转换为图片
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 保存图片到相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    }
                                      completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                Alert.title(@"提示").message(@"保存成功").action(@"确定", nil).show();
            });
        } else {
            NSString *errorStr = Str(@"图片保存失败: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                Alert.title(@"提示").message(errorStr).action(@"确定", nil).show();
            });
        }
    }];
}

- (void)setSaveSettingsForDict:(WQQQSavePicModel *)model {
    UIColor *cor = Color(@"black, 0.3");
    
    self.labelTitleBg.bgColor(cor);
    self.labelDesBg.bgColor(cor);
    
    self.labelTitle.str(model.weekday);
    self.labelDes.str(model.des);
    [self.imageViewBg sd_setImageWithURL:Url(model.url)
                        placeholderImage:Img(@"white")];
}

#pragma mark -
#pragma mark event response


#pragma mark -
#pragma mark setter && getter && lazy
- (id)imageViewBg {
    if (!_imageViewBg) {
        _imageViewBg = ({
            UIImageView *obj = [[UIImageView alloc] init];
            obj.clip.aspectFill.bgColor(@"random");
            obj.onClick(^(UIImageView *imgView) {
                [self saveViewAsImageToAlbum:imgView];
            });
            obj;
        });
    }
    
    return _imageViewBg;
}

- (id)labelTitle {
    if (!_labelTitle) {
        _labelTitle = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.color(@"white").fnt([UIFont boldSystemFontOfSize:16]).addTo(self.imageViewBg).str(@"默认");
            obj;
        });
    }
    
    return _labelTitle;
}

- (id)labelDes {
    if (!_labelDes) {
        _labelDes = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.color(@"white").fnt([UIFont boldSystemFontOfSize:9]).addTo(self.imageViewBg).str(@"默认");
            obj;
        });
    }
    
    return _labelDes;
}

- (id)labelTitleBg {
    if (!_labelTitleBg) {
        _labelTitleBg = ({
            UIView *obj = [[UIView alloc] init];
            obj.borderRadius(2);
            obj;
        });
    }
    
    return _labelTitleBg;
}

- (id)labelDesBg {
    if (!_labelDesBg) {
        _labelDesBg = ({
            UIView *obj = [[UIView alloc] init];
            obj.borderRadius(2);
            obj;
        });
    }
    
    return _labelDesBg;
}

- (id)viewCenter {
    if (!_viewCenter) {
        _viewCenter = ({
            UIView *obj = [[UIView alloc] init];
            
            obj;
        });
    }
    
    return _viewCenter;
}

@end

@implementation WQQQSavePicModel
//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{
//        @"ID":@"id"
//    };
//}
@end
