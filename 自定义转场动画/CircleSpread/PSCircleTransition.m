//
//  PSCircleTransition.m
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/13.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "PSCircleTransition.h"
#import "PSCircleSpreadController.h"
@implementation PSCircleTransition
+ (instancetype)transitionWithTransitionType:(PSCircleTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:
(PSCircleTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case PSCircleTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case PSCircleTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)presentAnimation: (id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    UIViewController *vcvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    NSLog(@"%@",NSStringFromClass(vcvc));
    PSCircleSpreadController *temp = fromVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆
    UIBezierPath *stratCycle = [UIBezierPath bezierPathWithRect:temp.buttonFrame];
    CGFloat x = MAX(temp.buttonFrame.origin.x, containerView.frame.size.width - temp.buttonFrame.origin.x);
    CGFloat y = MAX(temp.buttonFrame.origin.y, containerView.frame.size.height - temp.buttonFrame.origin.y);
    CGFloat radius = sqrt(pow(x, 2) + pow(y, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.view遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskeLayerAni = [CABasicAnimation animationWithKeyPath:@"path"];
    maskeLayerAni.delegate = self;
    //动画是加到layer上的，所以必须是CGPath，再将CGPath桥接为OC对象
    maskeLayerAni.fromValue = (__bridge id)(stratCycle.CGPath);
    maskeLayerAni.toValue = (__bridge id)(endCycle.CGPath);
    maskeLayerAni.duration = [self transitionDuration:transitionContext];
    maskeLayerAni.delegate = self;
    maskeLayerAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskeLayerAni setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskeLayerAni forKey:@"path"];
    
}
- (void)dismissAnimation: (id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    PSCircleSpreadController *temp = toVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGFloat radius = sqrt(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
#pragma mark -CAAnimationDelegate
/**
     动画结束
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case PSCircleTransitionTypePresent:{
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case PSCircleTransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewKey].view.layer.mask = nil;
            }
        }
            break;
    }
}
@end


