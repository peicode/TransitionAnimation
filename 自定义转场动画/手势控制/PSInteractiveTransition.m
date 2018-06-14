//
//  PSInteractiveTransition.m
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "PSInteractiveTransition.h"
@interface PSInteractiveTransition()
@property(nonatomic,weak) UIViewController *vc;
//手势方向
@property(nonatomic,assign) PSInteractiveTransitionGestureDirection direction;
//手势类型
@property(nonatomic,assign) PSInteractiveTransitionType type;
@end
@implementation PSInteractiveTransition
+ (instancetype)interactiveTransitionWithTransitionType:(PSInteractiveTransitionType)type GestureDirection:(PSInteractiveTransitionGestureDirection)direction{
    return [[self alloc]initWithTransitionType:type GestureDirection:direction];;
}
- (instancetype)initWithTransitionType:(PSInteractiveTransitionType)type GestureDirection:(PSInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

-(void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case PSInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            
        }
            break;
        case PSInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            
        }
            break;
        case PSInteractiveTransitionGestureDirectionUp:{
            
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
           
            persent = transitionY / panGesture.view.frame.size.width;
            
        }
            break;
        case PSInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
            
        }
            break;
        default:
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记状态，并且开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
- (void)startGesture{
    switch (_type) {
        case PSInteractiveTransitionTypePresent:{
            if (_presentConfig) {
                _presentConfig();
            }
        }
            break;
            
        case PSInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case PSInteractiveTransitionTypePush:{
            if (_pushConfig) {
                _pushConfig();
            }
        }
            break;
        case PSInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
