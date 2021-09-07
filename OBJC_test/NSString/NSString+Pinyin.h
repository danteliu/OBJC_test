//
//  NSString+Pinyin.h
//  OBJC_test
//
//  Created by liu dante on 2021/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Pinyin)
-(void)chineseConvertToPinYinFirstLetterWithCompletionBlock:(void(^)(NSString *mark))completion;/**<  异步获取字符串首字母 */
@end

NS_ASSUME_NONNULL_END
