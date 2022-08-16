//  HDHVerticalPMDView.h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class testcell;

@interface HDHVerticalPMDView : UIView
@property (nonatomic, strong) NSArray<NSString *> *data;/**<  数据 */
@property (nonatomic, assign) BOOL autoPage;/**<  自动翻页 默认 NO */
@property (nonatomic, strong) void (^selectForObj)(id obj);/**<  返回当前显示的index对应的数据对象 */
@end

@interface testcell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *textLabel;


@end
NS_ASSUME_NONNULL_END
