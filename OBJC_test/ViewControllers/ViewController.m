//
//  ViewController.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//


#import "OBJC_test-Swift.h"
#import "SaveInfoVC.h"

#import "ViewController.h"
#import "WQBYCyclePMDViewController.h"
#import "WQCradientPmdViewController.h"
#import "WQCyclePMDViewController.h"
#import "WQPMDViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    BaseHScrollview *h;
    UILabel *lab;
    NSRange targetRange;
    NSRange puts;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.cycleScrollView adjustWhenControllerViewWillAppera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.hbd_barHidden=YES;
    
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    
    self.vScroll.addTo(self.view);
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
    NSMutableArray *views = [NSMutableArray new];
    
    WQView *wqView1 = ({
        WQView *obj = [[WQView alloc] init];
        obj.textLable.str(@"保存数据");
        obj.addTo(self.itemsBgView);
        [views addObject:obj];
        obj.clickView = ^{
            SaveInfoVC *info = [[SaveInfoVC alloc] init];
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
        };
        obj;
    });
    WQView *wqView2 = ({
        WQView *obj = [[WQView alloc] init];
        obj.textLable.str(@"扫码");
        obj.addTo(self.itemsBgView);
        [views addObject:obj];
        obj.clickView = ^{
            //[self testNetLogManager];
            //[self testSwiftView];
            [self openScan];
        };
        obj;
    });
    WQView *wqView3 = ({
        WQView *obj = [[WQView alloc] init];
        obj.textLable.str(@"随机颜色");
        obj.addTo(self.itemsBgView);
        [views addObject:obj];
        obj.clickView = ^{
            RandomColorVC *info = [[RandomColorVC alloc] init];
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
        };
        obj;
    });
    
    [views mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)openScan {/**<  打开扫码页面 */
    [self.navigationController pushViewController:({
        ScanCodeVC *obj = [[ScanCodeVC alloc] init];
        obj.hidesBottomBarWhenPushed = YES;
        obj;
    })
                                         animated:YES];
}

- (void)clearWebcache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];// All kinds of data
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                               completionHandler:^{
        }];
    }
}

- (void)testSwiftView {
    RandomView *a = ({
        RandomView *obj = [[RandomView alloc] init];
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(180);
            make.left.right.offset(0);
            make.height.mas_equalTo(40);
        }];
        obj;
    });
}

- (void)testNetLogManager {
    [NetLogManager shareManager].tag = @"和多号";
    [NetLogManager shareManager].path = @"1111111111111111111111.url";
    [NetLogManager shareManager].header = @{
        @"abc": @"bldu"
    };
    [NetLogManager shareManager].parameter = @{
        @"1p": @"bldu"
    };
    [NetLogManager shareManager].returnResult = @{
        @"fjhvjxgo": @"这里是返回结果"
    };
    NSLog(@"%@", [NetLogManager shareManager]);
    NSLog(@"\n%@", [NetLogManager shareManager].mj_keyValues);
    
    [NetLogManager shareManager].tag = @"智荟港";
    [NetLogManager shareManager].path = @"222222222222222.url";
    [NetLogManager shareManager].header = @{
        @"2abc": @"bldu"
    };
    [NetLogManager shareManager].parameter = @{
        @"21p": @"bldu"
    };
    [NetLogManager shareManager].returnResult = @{
        @"2fjhvjxgo": @"这里是返回结果"
    };
}

- (void)test_group {/**<  测试gcdgroup  */
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (int i = 0; i < 10; i++) {
        dispatch_group_enter(downloadGroup);//备注:dispatch_group_enter 与 dispatch_group_leave成对出现
        [self testblock:^{
            NSLog(@"%d---%d", i, i);
            dispatch_group_leave(downloadGroup);
        }];
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)testblock:(void (^)(void))c {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        c();
    });
}

- (void)showAlert {
    AAQYAlertView *view = [AAQYAlertView getView:^(UIView *_Nonnull obj) {
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }];
    
    view.titles = @[@"确定", @"取消"];
    view.titleLB.str(@"测试");
    view.messageLB.str(@"测试内容");
    [view show];
    
    
    [@"你好" chineseConvertToPinYinFirstLetterWithCompletionBlock:^(NSString *_Nonnull mark) {
        NSLog(@"%@", mark);
    }];
}

- (void)createAttr {/**<  创建富文本 */
    //    id attr=AttStr(@"点击了",AttStr(@"协议").linkForLabel);
    lab = Label.addTo(self.view).bgColor(@"white").lines(3).onLink(^(NSString *text) {
        Log(text);
    });
    lab.userInteractionEnabled = YES;
    [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];
    
    NSAttributedString *plainText;
    NSAttributedString *plainText1;
    NSAttributedString *linkText;
    NSAttributedString *linkText1;
    
    plainText = [[NSMutableAttributedString alloc] initWithString:@"Add label links with UITapGestureRecognizer"
                                                       attributes:nil];
    linkText = [[NSMutableAttributedString alloc] initWithString:@"我们的东西"
                                                      attributes:@{
        NSForegroundColorAttributeName: [UIColor blueColor]
    }];
    plainText1 = [[NSMutableAttributedString alloc] initWithString:@"普通的"
                                                        attributes:nil];
    
    linkText1 = [[NSMutableAttributedString alloc] initWithString:@"乱七八糟"
                                                       attributes:@{
        NSForegroundColorAttributeName: [UIColor blueColor]
    }];
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    [attrText appendAttributedString:plainText];
    [attrText appendAttributedString:linkText];
    [attrText appendAttributedString:plainText1];
    [attrText appendAttributedString:linkText1];
    
    NSString *str = attrText.string;
    
    lab.attributedText = attrText;
    
    // ivar -- keep track of the target range so you can compare in the callback
    targetRange = [str rangeOfString:@"我们的东西"];
    puts = [str rangeOfString:@"乱七八糟"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(50);
        make.right.offset(-20);
    }];
}

- (void)HScro {
    h = [BaseHScrollview new];
    h.addTo(self.view).bgColor(@"random");
    [h mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
    }];
    
    UIView *obj = View.addTo(h.bgView).bgColor(@"random");
    [obj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
        make.width.mas_equalTo(1500);
    }];
}

- (void)getAttr {
    UILabel *one = Label.addTo(self.view).lines(0).lineGap(5).bgColor(@"random")
        .onClick(^(void) {
            Log(@"你好");
        });
    NSString *str = @"<h1>Demo iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts</h1>";
    
    one.str([self showInHTMLString:str]);
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(Insets(100, 0, 0, 0));
    }];
}

- (NSAttributedString *)showInHTMLString:(NSString *)str {/**<  根据HTML字符串显示HTML */
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding]
                                                                   options:@{
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
    }
                                                        documentAttributes:nil
                                                                     error:nil];
    
    return attrStr;
}

#pragma mark -
#pragma mark delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {/**<  点击轮播图 */
    WQCycleModel *model = self.cycleDatas[index];
    
    switch (model.type) {
        case ViewTypeCradientPmd:
            [self.navigationController pushViewController:({
                WQCradientPmdViewController *obj = [[WQCradientPmdViewController alloc] init];
                obj.hidesBottomBarWhenPushed = YES;
                obj;
            })
                                                 animated:YES];
            break;
            
        case ViewTypePMD:
            [self.navigationController pushViewController:({
                WQPMDViewController *obj = [[WQPMDViewController alloc] init];
                obj.hidesBottomBarWhenPushed = YES;
                obj;
            })
                                                 animated:YES];
            break;
            
        case ViewTypeCyclePMD:
            [self.navigationController pushViewController:({
                WQCyclePMDViewController *obj = [[WQCyclePMDViewController alloc] init];
                obj.hidesBottomBarWhenPushed = YES;
                obj;
            })
                                                 animated:YES];
            break;
            
        case ViewTypeCycleBYPMD:
            [self.navigationController pushViewController:({
                WQBYCyclePMDViewController *obj = [[WQBYCyclePMDViewController alloc] init];
                obj.hidesBottomBarWhenPushed = YES;
                obj;
            })
                                                 animated:YES];
            break;
            
        case ViewTypeGrid:
            [self.navigationController pushViewController:({
                WQGridViewController *obj = [[WQGridViewController alloc] init];
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

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [WQCycleCell class];
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    WQCycleCell *targetCell = (WQCycleCell *)cell;
    WQCycleModel *model = self.cycleDatas[index];
    
    [targetCell.image sd_setImageWithURL:Url(model.imgUrl) placeholderImage:nil];
    targetCell.textLabel.str(model.name);
}

#pragma mark -
#pragma mark 懒加载
- (id)vScroll {
    if (!_vScroll) {
        _vScroll = ({
            BaseVScrollview *obj = [[BaseVScrollview alloc] init];
            obj.infoSv.alwaysBounceVertical = YES;
            obj.addTo(self.view);
            obj;
        });
    }
    
    return _vScroll;
}

- (id)itemsBgView {
    if (!_itemsBgView) {
        _itemsBgView = ({
            UIView *obj = [[UIView alloc] init];
            
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

@end

@implementation WQCycleCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.image.addTo(self);
    self.textLabel.addTo(self);
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -
#pragma mark 懒加载
- (id)textLabel {
    if (!_textLabel) {
        _textLabel = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.bgColor(@"black,0.3").color(@"white").centerAlignment.fnt(13);
            obj;
        });
    }
    
    return _textLabel;
}

- (id)image {
    if (!_image) {
        _image = ({
            UIImageView *obj = [[UIImageView alloc] init];
            obj.aspectFill.bgColor(UIColor.clearColor);
            obj;
        });
    }
    
    return _image;
}

@end

@implementation WQCycleModel

@end
