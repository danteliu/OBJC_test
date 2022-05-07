//
//  HomeVC.m
//  CMCCSmartPark
//
//  Created by liu dante on 2022/3/17.
//

#import "HomeVC.h"
#import "ViewController.h"
#import "HBDNavigationController.h"
#import "UIViewController+HBD.h"
#import "HBDNavigationBar.h"
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent=NO;
    self.viewControllers=[self getBaseViews];
//    self.selectedIndex=4;
}

-(NSArray *)getTabarNames{
    return @[
        @"消息",
        @"知识库",
        @"工作台",
        @"通讯录",
        @"我的",
    ];
}

-(NSArray *)getBaseViews {
    NSArray*TabarNames=[self getTabarNames];
    
    return @[
        [self setNavViewControllerWithTabarModel:({
            TabarModel *obj=[[TabarModel alloc] init];
            obj.title=TabarNames[0];
            obj.targetVC=[[ViewController alloc] init];
            obj.selImg=@"random";
            obj.noSelImg=@"random";
            obj;
        })],
        [self setNavViewControllerWithTabarModel:({
            TabarModel *obj=[[TabarModel alloc] init];
            obj.title=TabarNames[1];
            obj.targetVC=[[ViewController alloc] init];
            
            obj.selImg=@"random";
            obj.noSelImg=@"random";
            obj;
        })],
        [self setNavViewControllerWithTabarModel:({
            TabarModel *obj=[[TabarModel alloc] init];
            obj.title=TabarNames[2];
            obj.targetVC=[[ViewController alloc] init];
            obj.selImg=@"random";
            obj.noSelImg=@"random";
            obj;
        })],
        [self setNavViewControllerWithTabarModel:({
            TabarModel *obj=[[TabarModel alloc] init];
            obj.title=TabarNames[3];
            obj.targetVC=[[ViewController alloc] init];
            obj.selImg=@"random";
            obj.noSelImg=@"random";
            obj;
        })],
        [self setNavViewControllerWithTabarModel:({
            TabarModel *obj=[[TabarModel alloc] init];
            obj.title=TabarNames[4];
            obj.targetVC=[[ViewController alloc] init];
            obj.selImg=@"random";
            obj.noSelImg=@"random";
            obj;
        })],
    ];
}
-(UINavigationController *)setNavViewControllerWithTabarModel:(TabarModel *)model {
    return  ({
        HBDNavigationController *obj = [[HBDNavigationController alloc]initWithRootViewController:model.targetVC];
        obj.navigationBar.translucent=NO;
        obj.tabBarItem.title = model.title;
        obj.tabBarItem.selectedImage = Img(model.selImg).resize(model.picW,model.picW).original;
        obj.tabBarItem.image=Img(model.noSelImg).resize(model.picW,model.picW).original;
        [obj.tabBarItem setTitleTextAttributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:model.fontSize]
        } forState:UIControlStateNormal];
        
        if (@available(iOS 13.0, *)) {
            //            UINavigationBarAppearance *appearance_nav =({
            //                UINavigationBarAppearance *navObj=[[UINavigationBarAppearance alloc] init];
            //                navObj.backgroundImage=model.navgationBarBg;
            //                navObj.shadowImage=model.navgationBarShadow;
            //                obj.navigationBar.standardAppearance = navObj;
            //                obj.navigationBar.scrollEdgeAppearance = navObj;
            //                navObj;
            //            });
            //
            UITabBarAppearance *appearance_bar = ({
                UITabBarAppearance *barObj=[[UITabBarAppearance alloc] init];;
                barObj.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:model.selectColor};
                barObj.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:model.noSelectColor};
                barObj.backgroundImage = model.tabbarBg;
                barObj.shadowImage = model.tabbarShadow;
                
                if (@available(iOS 15.0, *)) {
                    self.tabBar.scrollEdgeAppearance = barObj;
                } else {
                    // Fallback on earlier versions
                }
                self.tabBar.standardAppearance = barObj;
                barObj;
            });
            
        } else {
            [self.tabBar setBackgroundImage:model.tabbarBg];
            [self.tabBar setShadowImage:model.tabbarShadow];
            
            //            [obj.navigationBar setBackgroundImage:model.navgationBarBg forBarMetrics:UIBarMetricsDefault];
            //            [obj.navigationBar setShadowImage:model.navgationBarShadow];
            
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:model.noSelectColor} forState:UIControlStateNormal];
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:model.selectColor} forState:UIControlStateSelected];
        }
        obj;
    });
}
@end
@implementation TabarModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.picW=24;
        self.fontSize=11;
        self.selectColor=Color(@"#1372F0");
        self.noSelectColor=Color(@"#666666");
        
        self.tabbarBg=Img(@"white");
        self.tabbarShadow=Img(@"white");
        
        self.navgationBarBg=Img(@"white");
        self.navgationBarShadow=Img(@"white");
        
    }
    return self;
}
@end
