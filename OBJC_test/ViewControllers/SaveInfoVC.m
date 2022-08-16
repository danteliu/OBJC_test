//
//  SaveInfoVC.m
//  OBJC_test
//
//  Created by liu dante on 2021/11/17.
//

#import "SaveInfoVC.h"
@interface SaveInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SaveInfoVC
{
    NSUserDefaults *user;
    UITableView *infoTab;
    NSMutableArray *data;
    AddInfoView *addView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initData];
    [self initView];
}
- (void)initNav {/**<  导航  */
    UILabel *add=({
        UILabel *obj=Label.fnt(14).color(@"black").str(@"添加").onClick(^(void){
            [self addDatas];
        });
        obj;
    });
    
    UILabel *allRemove=({
        UILabel *obj=Label.fnt(14).color(@"black").str(@"删除全部").onClick(^(void){
            [user removeObjectForKey:infoKey];
            [self updateData];
        });
        obj;
    });
    
    UIBarButtonItem *allRemoveBar=[[UIBarButtonItem alloc] initWithCustomView:allRemove];
    UIBarButtonItem *addBar=[[UIBarButtonItem alloc] initWithCustomView:add];

    self.navigationItem.rightBarButtonItems=@[addBar,allRemoveBar];
}
- (void)addDatas {/**<  添加数据  */
    [self lazyAddInfoView];
    
    addView.isAnimationShwo(YES);
    [addView setPasteString];
}

-(AddInfoView *)lazyAddInfoView {
    if (!addView) {
        addView=({
            AddInfoView *obj=[AddInfoView new];
            obj.clickCommit = ^(SaveInfoModel * _Nonnull model) {
                NSLog(@"%@",model.mj_keyValues);
                [self updateDataSource:model];
            };
            obj.addTo([UIApplication sharedApplication].keyWindow);
            obj;
        });
        [addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return addView;
}
- (void)initData {/**<  初始化数据  */
    user=[NSUserDefaults standardUserDefaults];
    [self updateData];
}
-(void)updateData{
    if ([user objectForKey:infoKey]==nil) {
        data=[NSMutableArray new];
    }else{
        data=[NSMutableArray arrayWithArray:[user objectForKey:infoKey]];
    }
    [infoTab reloadData];
}

-(void)updateDataSource:(SaveInfoModel *)obj {
    [data addObject:obj];
    [self updateDataSourceForLocal];
    [self updateData];
}
-(void)updateDataSourceForLocal{/**<  更新本地数据源 */
    [user setObject:[SaveInfoModel mj_keyValuesArrayWithObjectArray:data] forKey:infoKey];
}
- (void)initView {/**<  初始化视图  */
    self.view.bgColor(@"random");
    infoTab =({
        UITableView *obj=[[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        obj.delegate=self;
        obj.dataSource=self;
        [obj setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        obj.estimatedRowHeight=60;
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        obj;
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"infoTabCell";
    SaveInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[SaveInfoCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    cell.addModel(data[indexPath.row]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SaveInfoModel *model=[SaveInfoModel mj_objectWithKeyValues:data[indexPath.row]];
    [UIPasteboard generalPasteboard].string = model.pasteContent;
}
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction =({
        UIContextualAction *obj=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                        title:@"删除"
                                                                      handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            [data removeObject:data[indexPath.row]];
            [self updateDataSourceForLocal];
            [self updateData];
        }];
        obj.backgroundColor = [UIColor redColor];
        obj;
    });
    UIContextualAction *editRowAction =({
        UIContextualAction *obj=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                        title:@"编辑"
                                                                      handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            NSLog(@"点击了编辑");
//            [data removeObject:data[indexPath.row]];
//            [self updateDataSourceForLocal];
//            [self updateData];
        }];
        obj.backgroundColor = [UIColor orangeColor];
        obj;
    });
    
    
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,editRowAction]];
    return config;
}

@end

@implementation AddInfoView
{
    UIView *bgView;
    UITextField *f1;
    UITextField *f2;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgColor(@"black,0.7").opacity(0);
        //        self.onClick(^(void){
        //            self.isAnimationShwo(NO);
        //        });
        bgView=View.addTo(self).bgColor(@"white").borderRadius(10);
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);//居中
            make.width.mas_equalTo(Screen.width*0.7);
            //            make.height.mas_equalTo(Screen.height*0.7);
        }];
        UILabel *mark1=Label.fnt(13).color(@"black").addTo(bgView).str(@"复制内容");
        UILabel *mark2=Label.fnt(13).color(@"black").addTo(bgView).str(@"内容描述");
        
        f1=TextField.fnt(13).addTo(bgView).border(0.5,@"random").borderRadius(5)
            .insets(0, 10, 0, 0).clearWhenFocus.hint(@"请输入复制内容");
        
        
        f2=TextField.fnt(13).addTo(bgView).border(0.5,@"random").borderRadius(5)
            .insets(0, 10, 0, 0).clearWhenFocus.hint(@"请输入内容描述");
        
        [self setPasteString];

        [mark1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(12);
        }];
        [f1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mark1.mas_bottom).offset(8);
            make.left.offset(12);
            make.right.offset(-12);
            make.height.mas_equalTo(44);
        }];
        [mark2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(f1.mas_bottom).offset(15);
            make.left.offset(12);
        }];
        
        [f2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mark2.mas_bottom).offset(8);
            make.left.offset(12);
            make.right.offset(-12);
            make.height.mas_equalTo(44);
            make.bottom.offset(-84);
        }];
        
        UILabel *commit=Label.fnt([UIFont boldSystemFontOfSize:15]).color(@"white").addTo(bgView).bgColor(@"random")
            .centerAlignment.borderRadius(5).str(@"确定").onClick(^(void){
                if (self.clickCommit) {
                    [UIPasteboard generalPasteboard].string=@"";//使用剪贴板后置为空
                    SaveInfoModel *m=[[SaveInfoModel alloc] init];
                    m.pasteContent=f1.text;
                    if (m.pasteContent.length==0) {
                        self.isAnimationShwo(NO);
                        return;
                    }
                    m.pasteDes=f2.text;
                    self.clickCommit(m);
                    
                }
                self.isAnimationShwo(NO);
            });
        UILabel *cancel=Label.fnt([UIFont boldSystemFontOfSize:15]).color(@"white").addTo(bgView).bgColor(@"random")
            .centerAlignment.borderRadius(5).str(@"取消").onClick(^(void){
                self.isAnimationShwo(NO);
            });
        
        NSMutableArray *views=[NSMutableArray new];
        [views addObject:commit];
        [views addObject:cancel];
        [views mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(f2.mas_bottom).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}
-(void)setPasteString{/**<  设置剪贴板内容 */
    NSString *pStr=[UIPasteboard generalPasteboard].string;
    f1.str([pStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
    f2.str(@"");
}
@end
