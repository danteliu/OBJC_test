//
//  SaveInfoCell.m
//  OBJC_test
//
//  Created by liu dante on 2021/11/17.
//

#import "SaveInfoCell.h"

@implementation SaveInfoCell {
    UILabel *fuvicontent;
    UILabel *fuviDes;
}

- (instancetype (^)(NSDictionary *res))addModel {/**<  添加数据模型 */
    return ^(NSDictionary *res){
        SaveInfoModel *m=[SaveInfoModel mj_objectWithKeyValues:res];
        m.pasteContent=[m.pasteContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        m.pasteDes=[m.pasteDes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        
        fuvicontent.str(m.pasteContent.length==0?@"复制内容: 当前记录无效,请左滑删除!!!":Str(@"复制内容: %@",m.pasteContent));
        fuviDes.str(m.pasteDes.length==0?@"复制内容: 空":Str(@"复制内容: %@",m.pasteDes));
        return self;
    };
}
-(instancetype)initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        fuvicontent = Label.fnt(13).color(@"black").leftAlignment.lines(0).lineGap(5).addTo(self).str(@"你好啊");
        [fuvicontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.left.offset(10);
            make.right.offset(-10);
        }];
        
        fuviDes = Label.fnt(12).color(@"black").leftAlignment.lines(0).lineGap(5).addTo(self).str(@"你好啊des");
        [fuviDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(fuvicontent.mas_bottom).offset(8);
            make.right.offset(-10);
            make.bottom.offset(-8);
        }];
        
        ({
            UIView *obj=View.bgColor(@"random").addTo(self);
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.offset(0);
                make.height.mas_equalTo(1);
            }];
        });
        
    }
    return self;
}
@end

@implementation SaveInfoModel

@end
