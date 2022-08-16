//
//  SaveInfoCell.h
//  OBJC_test
//
//  Created by liu dante on 2021/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveInfoCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
- (instancetype (^)(NSDictionary *res))addModel;/**<  添加数据模型 */
@end

@interface SaveInfoModel : NSObject
@property (nonatomic, strong) NSString * pasteContent;/**<  复制内容 */
@property (nonatomic, strong) NSString * pasteDes;/**<  内容说明*/

@end

NS_ASSUME_NONNULL_END
