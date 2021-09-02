//
//  UITapGestureRecognizer+test.h
//  OBJC_test
//
//  Created by liu dante on 2021/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITapGestureRecognizer (test)
- (BOOL)didTapAttributedTextInLabel:(UILabel *)label inRange:(NSRange)targetRange;
@end

NS_ASSUME_NONNULL_END
