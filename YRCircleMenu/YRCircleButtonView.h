//
//  YRCircleButton.h
//  YRCircleButton
//
//  Created by 王彦睿 on 2018/4/2.
//  Copyright © 2018 WangYanrui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CircleViewPosition) {
    CircleViewPositionDown,
    CircleViewPositionUp,
    CircleViewPositionLeft,
    CircleViewPositionRight
};

@interface YRCircleButtonView : UIView

- (instancetype)initWithcircleTitles:(NSArray <NSString *> *)circleTitles centerAnglePosition:(CircleViewPosition)centerAngle;

- (void)rotate;



@end
