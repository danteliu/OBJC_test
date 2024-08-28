//
//  WQSetUIVM.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import "PublicWebViewController.h"
#import "RandomColorVC.h"
#import "SaveInfoVC.h"
#import "WQCycleModel.h"
#import "WQSetUIVM.h"
#import "WQView.h"

#import "WQAutoLayoutHorizontalVC.h"
#import "WQAutoLayoutVC.h"
#import "WQBYCyclePMDViewController.h"
#import "WQCodeSipptesViewController.h"
#import "WQCradientPmdViewController.h"
#import "WQCycleCell.h"
#import "WQCyclePMDViewController.h"
#import "WQGridViewController.h"
#import "WQPMDViewController.h"
#import "WQRuntimeViewController.h"
#import "WQTimeDependentVC.h"



@interface WQSetUIVM ()<SDCycleScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/// 图片选择器
@property (nonatomic, strong) UIImagePickerController *imagePicker;
/// 竖向 ScrollView
@property (nonatomic, strong) BaseVScrollview *vScroll;

@property (nonatomic, strong) UIView *itemsBgView; /**<  <#属性注释#> */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView; /**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <WQCycleModel *> *cycleDatas;/**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <WQView *> *viewsItem;/**<  cell的数组 */

@end

@implementation WQSetUIVM
- (void)cellUI {
    if (self.currentViewContoller == nil) {
        DDLog(@"控制器初始化失败!!!! 请检查!!!");
    }

    self.currentViewContoller.hbd_barTintColor = Color(@"white,1");
    self.currentViewContoller.hbd_barShadowHidden = YES;

    self.vScroll.addTo(self.currentViewContoller.view);
    [self.vScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //接下来自定义ui
    UIView *testView = [[UIView alloc] init];
    testView.bgColor(@"random").addTo(self.vScroll.bgView);
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(3000);
    }];
}

- (void)setupUI {
    if (self.currentViewContoller == nil) {
        DDLog(@"控制器初始化失败!!!! 请检查!!!");
    }

    self.currentViewContoller.hbd_barTintColor = Color(@"white,1");
    self.currentViewContoller.hbd_barShadowHidden = YES;

    self.vScroll.addTo(self.currentViewContoller.view);
    self.cycleScrollView.addTo(self.vScroll.bgView);
    self.itemsBgView.addTo(self.vScroll.bgView);

    [self.vScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.mas_equalTo(200);
    }];

    [self.itemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];

    [self.viewsItem enumerateObjectsUsingBlock:^(WQView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        obj.addTo(self.itemsBgView);
    }];

    [self.viewsItem mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:0.4 leadSpacing:0 tailSpacing:0];
    [self.viewsItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark -
#pragma mark setupUI event
/// 显示图片选择控件
/// - Parameter allowsEditing: 编辑状态
- (void)showImagePickerWithEditing:(BOOL)allowsEditing {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;// 设置代理
    self.imagePicker.allowsEditing = allowsEditing; // 设置是否允许编辑

    // 检查设备是否支持相机，如果支持则使用相机，否则使用照片库
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    } else {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }

    // 在视图控制器中弹出图片选择器
    [self.currentViewContoller presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark SDCycleScrollView delegate
/// 点击轮播图
/// - Parameters:
///   - cycleScrollView:
///   - index: 位置
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    WQCycleModel *model = self.cycleDatas[index];
    UINavigationController *nav = self.currentViewContoller.navigationController;

    switch (model.type) {
        case ViewTypeTimeDependent:
            [nav pushViewController:({
            WQTimeDependentVC *obj = [[WQTimeDependentVC alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeCradientPmd:
            [nav pushViewController:({
            WQCradientPmdViewController *obj = [[WQCradientPmdViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypePMD:
            [nav pushViewController:({
            WQPMDViewController *obj = [[WQPMDViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeCyclePMD:
            [nav pushViewController:({
            WQCyclePMDViewController *obj = [[WQCyclePMDViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeCycleBYPMD:
            [nav pushViewController:({
            WQBYCyclePMDViewController *obj = [[WQBYCyclePMDViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeGrid:
            [nav pushViewController:({
            WQGridViewController *obj = [[WQGridViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeTimeAutoLayoutVertical:
            [nav pushViewController:({
            WQAutoLayoutVC *obj = [[WQAutoLayoutVC alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeTimeAutoLayoutHorizontal:
            [nav pushViewController:({
            WQAutoLayoutHorizontalVC *obj = [[WQAutoLayoutHorizontalVC alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeCodeSnippets:
            [nav pushViewController:({
            WQCodeSipptesViewController *obj = [[WQCodeSipptesViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];
            break;

        case ViewTypeRuntime:
            [nav pushViewController:({
            WQRuntimeViewController *obj = [[WQRuntimeViewController alloc] init];
            obj.hidesBottomBarWhenPushed = YES;
            obj;
        })
                           animated:YES];

            break;


        default:
            break;
    }


    Log(index);
    Log(model.type);
}

/// 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [WQCycleCell class];
}

/// 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    WQCycleCell *targetCell = (WQCycleCell *)cell;
    WQCycleModel *model = self.cycleDatas[index];

    [targetCell.image sd_setImageWithURL:Url(model.imgUrl) placeholderImage:nil];
    targetCell.textLabel.str(model.name);
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage]; // 编辑后的图片
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage]; // 原始图片

    DDLog(@"进入了这里");
    // 在此处处理选择的图片
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    DDLog(@"销毁");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark public lazy
- (id)vScroll {
    if (!_vScroll) {
        _vScroll = ({
            BaseVScrollview *obj = [[BaseVScrollview alloc] init];
            obj.infoSv.alwaysBounceVertical = YES;
            obj;
        });
    }

    return _vScroll;
}

#pragma mark -
#pragma mark setupUI lazy
- (id)itemsBgView {
    if (!_itemsBgView) {
        _itemsBgView = ({
            UIView *obj = [[UIView alloc] init];
            obj.bgColor(@"black");
            obj;
        });
    }

    return _itemsBgView;
}

- (id)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = ({
            SDCycleScrollView *obj = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:Img(@"red").resize(Screen.width, Screen.height)];
            obj.autoScrollTimeInterval = 2;
            obj.infiniteLoop = YES;
            obj.autoScroll = NO;
            obj.showPageControl = NO;
            [obj setBannerImageViewContentMode:(UIViewContentModeScaleAspectFill)];
            NSMutableArray *arr = [[NSMutableArray alloc] init];

            for (NSInteger i = 0; i < self.cycleDatas.count; i++) {
                [arr addObject:@"1"];
            }

            obj.imageURLStringsGroup = arr;
            obj;
        });
    }

    return _cycleScrollView;
}

- (id)cycleDatas {
    if (!_cycleDatas) {
        _cycleDatas = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"Runtime";
                m.type = ViewTypeRuntime;
                m.imgUrl = @"https://images.unsplash.com/photo-1663124164789-92ad4f9b7dcd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MzMzNTQ4Mw&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"代码段";
                m.type = ViewTypeCodeSnippets;
                m.imgUrl = @"https://images.unsplash.com/photo-1663124164789-92ad4f9b7dcd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MzMzNTQ4Mw&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];


            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"自动横布局";
                m.type = ViewTypeTimeAutoLayoutHorizontal;
                m.imgUrl = @"https://images.unsplash.com/photo-1661417456384-af20a862790d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MjM4ODY4Nw&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"自动竖布局";
                m.type = ViewTypeTimeAutoLayoutVertical;
                m.imgUrl = @"https://images.unsplash.com/photo-1661937303423-f251f4b80c8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MjYyMTkwMg&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];
            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"时间相关";
                m.type = ViewTypeTimeDependent;
                m.imgUrl = @"https://images.unsplash.com/photo-1659985799606-61175dea9e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MjAyMTIxNQ&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"弹幕";
                m.type = ViewTypePMD;
                m.imgUrl = @"https://images.unsplash.com/photo-1660316795448-21fdd1c466af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDUzMTAwNw&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"渐变轮播图";
                m.type = ViewTypeCradientPmd;
                m.imgUrl = @"https://images.unsplash.com/photo-1660111940516-f17cd23f12a4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTQ4MzAwMg&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];
            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"自定义实现渐进轮播";
                m.type = ViewTypeCyclePMD;
                m.imgUrl = @"https://images.unsplash.com/photo-1659862925130-816e4f8535ce?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDUzMTAzMw&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"参考北移实现渐进轮播";
                m.type = ViewTypeCycleBYPMD;
                m.imgUrl = @"https://images.unsplash.com/photo-1660404871825-6172f096ebfd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDcyMTgyNg&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            [obj addObject:({
                WQCycleModel *m = [[WQCycleModel alloc] init];
                m.name = @"自定义格子视图";
                m.type = ViewTypeGrid;
                m.imgUrl = @"https://images.unsplash.com/photo-1658660854824-147bd34cd243?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDgwOTQzNQ&ixlib=rb-1.2.1&q=80&w=1080";
                m;
            })];

            obj;
        });
    }

    return _cycleDatas;
}

- (id)viewsItem {
    if (!_viewsItem) {
        WeakifySelf();

        _viewsItem = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];

            [obj addObject:({
                WQView *view = [[WQView alloc] init];

                view.addModel(@{
                    @"name": @"保存图片到本地",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1661155528331-d03a2a82c22b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTY4MQ&ixlib=rb-1.2.1&q=80&w=1080",
                    });

                view.clickView = ^{
                    WQSaveViewController *info = [[WQSaveViewController alloc] init];
                    info.hidesBottomBarWhenPushed = YES;
                    [self.currentViewContoller.navigationController pushViewController:info
                                                                              animated:YES];
                };
                view;
            })];

            [obj addObject:({
                WQView *view = [[WQView alloc] init];

                view.addModel(@{
                    @"name": @"测试桥接库",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1661155528331-d03a2a82c22b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTY4MQ&ixlib=rb-1.2.1&q=80&w=1080",
                    });

                view.clickView = ^{
                    PublicWebViewController *info = [[PublicWebViewController alloc] init];
                    info.hidesBottomBarWhenPushed = YES;
                    [self.currentViewContoller.navigationController pushViewController:info
                                                                              animated:YES];
                };
                view;
            })];


            [obj addObject:({
                WQView *view = [[WQView alloc] init];

                view.addModel(@{
                    @"name": @"保存数据",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1661155528331-d03a2a82c22b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTY4MQ&ixlib=rb-1.2.1&q=80&w=1080",
                    });

                view.clickView = ^{
                    SaveInfoVC *info = [[SaveInfoVC alloc] init];
                    info.hidesBottomBarWhenPushed = YES;
                    [self.currentViewContoller.navigationController pushViewController:info
                                                                              animated:YES];
                };
                view;
            })];
            [obj addObject:({
                WQView *view = [[WQView alloc] init];
                view.addModel(@{
                    @"name": @"扫码",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1659785814117-a9b958b06d81?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTY5NA&ixlib=rb-1.2.1&q=80&w=1080",
                    });
                view.clickView = ^{
                    //[self testNetLogManager];
                    //[self testSwiftView];

                    [weakSelf.currentViewContoller.navigationController pushViewController:({
                        ScanCodeVC *obj = [[ScanCodeVC alloc] init];
                        obj.hidesBottomBarWhenPushed = YES;
                        obj;
                    })
                                                                                  animated:YES];
                };
                view;
            })];

            [obj addObject:({
                WQView *view = [[WQView alloc] init];
                view.addModel(@{
                    @"name": @"随机颜色",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1660089869502-3b4322a46e0e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTcxMg&ixlib=rb-1.2.1&q=80&w=1080",
                    });
                view.clickView = ^{
                    RandomColorVC *info = [[RandomColorVC alloc] init];
                    info.hidesBottomBarWhenPushed = YES;
                    [self.currentViewContoller.navigationController pushViewController:info
                                                                              animated:YES];
                };
                view;
            })];

            [obj addObject:({
                WQView *view = [[WQView alloc] init];
                view.addModel(@{
                    @"name": @"获取照片",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1660089869502-3b4322a46e0e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTcxMg&ixlib=rb-1.2.1&q=80&w=1080",
                    });
                view.clickView = ^{
                    [self showImagePickerWithEditing:YES];
                };
                view;
            })];

            [obj addObject:({
                WQView *view = [[WQView alloc] init];
                view.addModel(@{
                    @"name": @"动态设置cell的缩放比例",
                    @"imgBgUrl": @"https://images.unsplash.com/photo-1660089869502-3b4322a46e0e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MTc2MTcxMg&ixlib=rb-1.2.1&q=80&w=1080",
                    });
                view.clickView = ^{
                    WQAdjustCellScaleVC *adCell = [[WQAdjustCellScaleVC alloc] init];
                    adCell.hidesBottomBarWhenPushed = YES;
                    [weakSelf.currentViewContoller.navigationController pushViewController:adCell animated:YES];
                };
                view;
            })];
            obj;
        });
    }

    return _viewsItem;
}

@end
