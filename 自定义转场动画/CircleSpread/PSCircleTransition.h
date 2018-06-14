//
//  PSCircleTransition.h
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/13.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PSCircleTransitionType) {
    PSCircleTransitionTypePresent = 0,
    PSCircleTransitionTypeDismiss
};
@interface PSCircleTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property(nonatomic, assign) PSCircleTransitionType type;

+ (instancetype)transitionWithTransitionType:(PSCircleTransitionType)type;
- (instancetype)initWithTransitionType:
    (PSCircleTransitionType)type;

@end
