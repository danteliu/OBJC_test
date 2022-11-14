//
//  WQRuntimeViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/17.
//

#import "WQRuntimeViewController.h"
#import "WQTeacher.h"

@interface WQRuntimeViewController ()
@property (nonatomic, strong) BaseVScrollview *scrollViewMain; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelSave; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelGet; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelOpenScheme;/**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelTestChainModel;/**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <UIView *> *arrayLables; /**<  <#属性注释#> */
@property (nonatomic, strong) ChainTestView *testView;
@end

@implementation WQRuntimeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initData];
    [self initView];
}

- (void)initNavigation {/**<  初始化导航栏 */
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white, 1");
    self.hbd_barShadowHidden = YES;
    self.title = @"Runtime";
}

- (void)initData {/**<  初始化数据 */
}

- (void)initView {/**<  初始化视图 */
    [self.view addSubview:self.scrollViewMain];

    [self.scrollViewMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.arrayLables enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.addTo(self.scrollViewMain.bgView);
    }];
    [self.arrayLables mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.arrayLables mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark -
#pragma mark event
- (void)saveModel {/**<  保存模型 */
    /**<
       1. stringByAppendingString是字符串拼接，拼接路径时要在名称前加“/”
       2. stringByAppendingPathComponent是路径拼接，会在字符串前自动添加“/”，成为完整路径
     */
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:@"dante.kkk"];
    WQTeacher *t = [[WQTeacher alloc] init];

    t.stringAge = @"14";
    t.stringName = @"dante";
    t.stringAge1 = @"dd";
    t.stringAge2 = @"dd2";
    t.stringAge3 = @"dd3";
    WQTeacherType *type = [[WQTeacherType alloc] init];
    type.stringStar = @"5";
    t.type = type;

    [NSKeyedArchiver archiveRootObject:t toFile:filePath];
}

- (void)getModel {/**<  获取模型 */
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:@"dante.kkk"];
    WQTeacher *t = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    Log(t.type.stringStar);
    Log([t mj_keyValues]);
}

#pragma mark -
#pragma mark lazy
- (id)scrollViewMain {
    if (!_scrollViewMain) {
        _scrollViewMain = ({
            BaseVScrollview *obj = [[BaseVScrollview alloc] init];
            obj.infoSv.alwaysBounceVertical = YES;
            obj;
        });
    }

    return _scrollViewMain;
}

- (id)labelSave {
    if (!_labelSave) {
        _labelSave = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.str(@"存").color(@"white").centerAlignment.bgColor(@"random");
            obj.onClick(^(void) {
                [self saveModel];
            });
            obj;
        });
    }

    return _labelSave;
}

- (id)labelGet {
    if (!_labelGet) {
        _labelGet = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.str(@"取").color(@"white").centerAlignment.bgColor(@"random");
            obj.onClick(^(void) {
                [self getModel];
            });
            obj;
        });
    }

    return _labelGet;
}

- (id)labelOpenScheme {
    if (!_labelOpenScheme) {
        _labelOpenScheme = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.str(@"打开北移scheme").color(@"white").centerAlignment.bgColor(@"random");
            obj.onClick(^(void) {
                [self openBeijingCmcc];
            });
            obj;
        });
    }

    return _labelOpenScheme;
}
- (id)labelTestChainModel {
    if (!_labelTestChainModel) {
        _labelTestChainModel = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.str(@"检查引用问题").color(@"white").centerAlignment.bgColor(@"random");
            obj.userInteractionEnabled=YES;
            [obj addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkSele)]];
//            obj.onClick(^(void) {
//                [self checkSele];
//            });
            obj;
        });
    }

    return _labelTestChainModel;
}
- (void)checkSele {/**<  <#注释#> */
    self.testView=[[ChainTestView alloc] init];
    Log(@"释放前:");
    Log(_testView.stringTest);
    self.testView.addModel(@{@"1":@"我的东西"});
    self.testView=nil;
}


- (void)openBeijingCmcc {/**<  <#注释#> */
//    NSURL *url = [NSURL URLWithString:@"weixin://"];
    NSURL *url=[NSURL URLWithString:@"cn.10086.app://url=https://app.10086.cn/cmcc-app/flow/flowHome.html"];
    Log([[UIApplication sharedApplication] canOpenURL:url]);
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            Log(@"打开状态:");
            Log(success);
        }];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (id)arrayLables {
    if (!_arrayLables) {
        _arrayLables = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            [obj addObject:self.labelSave];
            [obj addObject:self.labelGet];
            [obj addObject:self.labelOpenScheme];
            [obj addObject:self.labelTestChainModel];
            obj;
        });
    }

    return _arrayLables;
}
- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end

@implementation ChainTestView


- (void (^)(NSDictionary * _Nonnull res))addModel{
//    __weak typeof(self) weakSelf = self;

    return ^(NSDictionary * _Nonnull res){

        self.stringTest.str(res);
        Log(@"调用addModel后:");
        Log(self.stringTest);
    };
}

- (instancetype)init {
    if (self = [super init]) {
        self.stringTest.str(@"初始化字符串");
    }
    return self;
}
- (id)stringTest{
    if (!_stringTest) {
        _stringTest=[[UILabel alloc] init];
    }
    return _stringTest;
}

- (void)dealloc {
    Log(@"释放后:");
    Log(_stringTest);
}



@end
