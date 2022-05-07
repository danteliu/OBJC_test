//
//  RandomColorVC.m
//  OBJC_test
//
//  Created by liu dante on 2022/5/7.
//

#import "RandomColorVC.h"

@interface RandomColorVC ()
@property (nonatomic, strong) UITableView * tab;/**<  底层tab */
@property (nonatomic, strong) NSMutableArray * datas;/**<  底层tab */
@end

@implementation RandomColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tab.addTo(self.view);
    
    [self.tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
//    [self getData];
}
-(void)getData{
    [ManagerNet getRandomColor:({
        NetRequestModel *obj=[[NetRequestModel alloc] init];
        
        obj;
    }) success:^(NetResponseModel * _Nonnull rsp) {
        Log(rsp.xxx);
        self.datas=[NSMutableArray arrayWithArray:rsp.xxx];
        [self.tab reloadData];
    } error:^(NSError * _Nonnull error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"hhhhh";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
//    NSDictionary *res=self.datas[indexPath.row];
    UIColor *cor=Color(@"random");
    cell.backgroundColor=cor;
    cell.textLabel.str([self hexStringFromColor:cor]);
    return cell;
}
- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
-(id)datas{
    if (!_datas) {
        _datas=({
            NSMutableArray *obj=[[NSMutableArray alloc] init];
            
            obj;
        });
    }
    return _datas;
}
-(id)tab{
    if (!_tab) {
        _tab=({
            UITableView *obj=[[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
            obj.delegate=self;
            obj.dataSource=self;
            [obj setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
            obj.estimatedRowHeight=60;

            obj;
        });
    }
    return _tab;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
