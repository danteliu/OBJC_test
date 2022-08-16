//
//  HDHScrollPlusView.h
//  OneCardMultiNumber
//
//  Created by liu dante on 2021/8/6.
//  Copyright © 2021 和多号. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseHScrollview : UIView
@property (nonatomic, strong) UIScrollView* infoSv;/**<  承载的scrollView */
@property (nonatomic, strong) UIView* bgView;/**<  内容视图的承载view */
-(instancetype)initWithFrame:(CGRect)frame;
@end


@interface BaseVScrollview : UIView
@property (nonatomic, strong) UIScrollView* infoSv;/**<  承载的scrollView */
@property (nonatomic, strong) UIView* bgView;/**<  内容视图的承载view */

-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
