//
//  PSPresentOneTransition.h
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PSPresentOneTransitionType) {
    PSPresentOneTransitionTypePresent = 0,
    PSPresentOneTransitionTypeDismiss = 1
};
@interface PSPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)PSPresentOneTransitionType tranType;
+ (instancetype)transitionWithTransitionType: (PSPresentOneTransitionType)type;
- (instancetype)initWithTransitiontype:(PSPresentOneTransitionType)type;
@end
