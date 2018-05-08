//
//  YRCircleButton.m
//  YRCircleButton
//
//  Created by 王彦睿 on 2018/4/2.
//  Copyright © 2018 WangYanrui. All rights reserved.
//

#import "YRCircleButtonView.h"
@interface YRCircleMenuInternalView : UIView

@end

@implementation YRCircleMenuInternalView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}


@end

@interface YRCircleButtonView()

@property (nonatomic, strong) NSMutableArray <UIButton *> *circleButtons;

@property (nonatomic, strong) NSMutableArray <YRCircleMenuInternalView *> *circleButtonViews;

@property (nonatomic, assign) CircleViewPosition circleViewPosition;

@property (nonatomic, strong) UIView *centerImageView;

@end

@implementation YRCircleButtonView



- (instancetype)initWithcircleTitles:(NSArray <NSString *> *)circleTitles centerAnglePosition:(CircleViewPosition)centerAnglePosition {
    if (self = [super init]) {
        _circleButtons = [NSMutableArray array];
        _circleButtonViews = [NSMutableArray array];
        _centerImageView = [[UIView alloc] init];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
        for (int i = 0; i < circleTitles.count; i++) {
            NSString * singleTile = circleTitles[i];
            UIButton *singleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [_circleButtons addObject:singleButton];
            YRCircleMenuInternalView *buttonView = [[YRCircleMenuInternalView alloc] init];
            [buttonView addSubview:singleButton];
            [singleButton setImage:[UIImage animatedImageNamed:@"h" duration:0.5] forState:UIControlStateNormal];
            [singleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -58, 0, 0)];
            [singleButton setTitle:singleTile forState:UIControlStateNormal];
            singleButton.titleLabel.font = [UIFont systemFontOfSize:12];
            buttonView.translatesAutoresizingMaskIntoConstraints = NO;
            buttonView.userInteractionEnabled = YES;
            singleButton.userInteractionEnabled = YES;
            singleButton.translatesAutoresizingMaskIntoConstraints = NO;
            [_centerImageView addSubview:buttonView];
            [_circleButtonViews addObject:buttonView];
        }
        
        _centerImageView.backgroundColor = [UIColor colorWithRed:70 / 255.0 green:158 / 255.0 blue:157 / 255.0 alpha:1.0];
        _centerImageView.layer.cornerRadius = 50.0;
        _centerImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_centerImageView];
        _circleViewPosition = centerAnglePosition;
    }
    return self;
}

- (void)layoutSubviews {
    [self addConstraints];
}

- (void)addConstraints {
    [self createCenterCircle];
}

- (void)createCenterCircle {
    [NSLayoutConstraint activateConstraints:
     @[[_centerImageView.heightAnchor constraintEqualToConstant:100],
       [_centerImageView.widthAnchor constraintEqualToConstant:100],
       [_centerImageView.centerYAnchor constraintEqualToAnchor:self.topAnchor constant:140],
       [_centerImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:140],
       [_centerImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-40],
       [_centerImageView.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-140]]
     ];
    for (int i = 0; i < self.circleButtonViews.count; i++) {
        YRCircleMenuInternalView *buttonView = self.circleButtonViews[i];
        [NSLayoutConstraint activateConstraints:
         @[[buttonView.leadingAnchor constraintEqualToAnchor:_centerImageView.leadingAnchor constant:-40],
           [buttonView.centerYAnchor constraintEqualToAnchor:_centerImageView.centerYAnchor],
           [buttonView.trailingAnchor constraintEqualToAnchor:_centerImageView.trailingAnchor constant:40]]
         ];
        UIButton *singleButton = self.circleButtons[i];
        [NSLayoutConstraint activateConstraints:
         @[[singleButton.trailingAnchor constraintEqualToAnchor:buttonView.trailingAnchor],
           [singleButton.centerYAnchor constraintEqualToAnchor:buttonView.centerYAnchor],
           [singleButton.heightAnchor constraintEqualToConstant:40],
           [singleButton.widthAnchor constraintEqualToConstant:40],
           [singleButton.topAnchor constraintEqualToAnchor:buttonView.topAnchor],
           [singleButton.bottomAnchor constraintEqualToAnchor:buttonView.bottomAnchor]]
         ];
    }
    [self sendSubviewToBack:_centerImageView];
}

- (void)rotate {
    CGFloat rads = 0.0f;
    __block CGFloat pp = -M_PI_2;
    switch (self.circleViewPosition) {
        case CircleViewPositionUp:
            rads = M_PI_2;
            break;
        case CircleViewPositionDown:
            rads = -M_PI_2;
            break;
        case CircleViewPositionLeft:
            rads = 0;
            break;
        case CircleViewPositionRight:
            rads = M_PI;
            break;
        default:
            break;
    }
    self.transform = CGAffineTransformMakeRotation(rads);
    
    for (int i = 0; i < self.circleButtonViews.count; i++) {
        YRCircleMenuInternalView *circleButtonView = self.circleButtonViews[i];
        circleButtonView.transform = CGAffineTransformMakeRotation(pp);
        UIButton *singleButton = _circleButtons[i];
        singleButton.transform = CGAffineTransformMakeRotation(-pp);
        pp = pp + M_PI / ((CGFloat)self.circleButtons.count - 1);
        
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}


@end
