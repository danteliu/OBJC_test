//
//  WQRuntimeViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/17.
//

#import "WQRuntimeViewController.h"
#import "WQTeacher.h""

@interface WQRuntimeViewController ()
@property (nonatomic, strong) BaseVScrollview *scrollViewMain; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel * labelSave;/**<  <#属性注释#> */
@property (nonatomic, strong) UILabel * labelGet;/**<  <#属性注释#> */
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
    
    [self.scrollViewMain.bgView addSubview:self.labelSave];
    [self.scrollViewMain.bgView addSubview:self.labelGet];
    
    [self.scrollViewMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.labelSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(30);
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.labelGet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.labelSave.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
        make.bottom.offset(0);
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
    NSString *filePath=[documentsDir stringByAppendingPathComponent:@"dante.kkk"];
    WQTeacher *t=[[WQTeacher alloc] init];
    t.stringAge=@"14";
    t.stringName=@"dante";
    t.stringAge1=@"dd";
    t.stringAge2=@"dd2";
    t.stringAge3=@"dd3";
    WQTeacherType*type= [[WQTeacherType alloc] init];
    type.stringStar=@"5";
    t.type=type;
    
    [NSKeyedArchiver archiveRootObject:t toFile:filePath];
}
- (void)getModel {/**<  获取模型 */
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath=[documentsDir stringByAppendingPathComponent:@"dante.kkk"];
    WQTeacher *t =[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    Log(t.type.stringStar);
    Log([t mj_keyValues]);
}
#pragma mark -
#pragma mark lazy
-(id)scrollViewMain{
    if (!_scrollViewMain) {
        _scrollViewMain=({
            BaseVScrollview *obj = [[BaseVScrollview alloc] init];
            obj.infoSv.alwaysBounceVertical = YES;
            obj;
        });
    }
    return _scrollViewMain;
}
-(id)labelSave{
    if (!_labelSave) {
        _labelSave=({
            UILabel *obj=[[UILabel alloc] init];
            obj.str(@"存").color(@"white").centerAlignment.bgColor(@"random");
            obj.onClick(^(void){
                [self saveModel];
            });
            obj;
        });
    }
    return _labelSave;
}

-(id)labelGet{
    if (!_labelGet) {
        _labelGet=({
            UILabel *obj=[[UILabel alloc] init];
            obj.str(@"取").color(@"white").centerAlignment.bgColor(@"random");
            obj.onClick(^(void){
                [self getModel];
            });
            obj;
        });
    }
    return _labelGet;
}
@end
