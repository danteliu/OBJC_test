//
//  HDHScrollPlusView.h
//  OneCardMultiNumber
//
//  Created by liu dante on 2021/8/6.
//  Copyright © 2021 和多号. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ScrollDireH=0,
    ScrollDireV,
} ScrollDire;

@interface HDHScrollPlusView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,assign)ScrollDire Dire;
-(UIView *)layoutView;/**<  布局targetView */
-(UIScrollView *)Scrol;/**<  承载的UIScrollView */
@end

NS_ASSUME_NONNULL_END
