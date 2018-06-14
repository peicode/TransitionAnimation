//
//  PSPresentTwoController.h
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PSPresentTwoControllerDelegate <NSObject>
- (void)presentedTwoControllerPressedDismiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;
@end
@interface PSPresentTwoController : UIViewController
@property(nonatomic,assign) id<PSPresentTwoControllerDelegate> delegate;
@end
