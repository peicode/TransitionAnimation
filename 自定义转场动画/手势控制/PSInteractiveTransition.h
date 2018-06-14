//
//  PSInteractiveTransition.h
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureConfig) (void);

typedef NS_ENUM(NSUInteger,PSInteractiveTransitionGestureDirection) {
    //手势方向
    PSInteractiveTransitionGestureDirectionLeft = 0,
    PSInteractiveTransitionGestureDirectionRight,
    PSInteractiveTransitionGestureDirectionUp,
    PSInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, PSInteractiveTransitionType) {
    //手势控制哪种转场
    PSInteractiveTransitionTypePresent = 0,
    PSInteractiveTransitionTypeDismiss,
    PSInteractiveTransitionTypePush,
    PSInteractiveTransitionTypePop
};
@interface PSInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 记录是否开始手势，判断pop操作是手势触发还是返回键触发
 */
@property(nonatomic,assign) BOOL interation;

/**
 促发手势present的时候的config，config中初始化并present需要弹出的控制器
 */
@property (nonatomic,copy) GestureConfig presentConfig;
@property (nonatomic,copy) GestureConfig pushConfig;

//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(PSInteractiveTransitionType)type GestureDirection:(PSInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(PSInteractiveTransitionType)type GestureDirection:(PSInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
