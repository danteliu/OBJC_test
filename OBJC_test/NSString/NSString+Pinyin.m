//
//  NSString+Pinyin.m
//  OBJC_test
//
//  Created by liu dante on 2021/9/7.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)
-(void)chineseConvertToPinYinFirstLetterWithCompletionBlock:(void(^)(NSString *mark))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_queue_t queue2 = dispatch_queue_create("CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group,queue2,^{
            NSMutableString *mutableString = [[NSMutableString alloc] initWithString:self];
            CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
            NSMutableString *outputPinyin = [[NSMutableString alloc] init];
            NSArray<NSString *> *pinyinArray = [mutableString componentsSeparatedByString:@" "];
            for (NSString *pinyin in pinyinArray) {
                [outputPinyin appendFormat:@"%c", [pinyin characterAtIndex:0]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([outputPinyin uppercaseString]);
            });
        });
    });
}
@end
