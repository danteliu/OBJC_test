//
//  ViewController.h
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import <UIKit/UIKit.h>
#import "RandomColorVC.h"
typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypePMD,/**<  跑马灯 */
};
@interface ViewController : UIViewController<SDCycleScrollViewDelegate>


@end

