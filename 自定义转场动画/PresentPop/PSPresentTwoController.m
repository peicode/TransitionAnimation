//
//  PSPresentTwoController.m
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "PSPresentTwoController.h"
#import "Masonry.h"
#import "PSInteractiveTransition.h"
#import "PSPresentOneTransition.h"
@interface PSPresentTwoController ()<UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)PSInteractiveTransition *interactiveDismiss;
@property(nonatomic,strong)PSInteractiveTransition *interactivePush;
@end

@implementation PSPresentTwoController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //让自己成为代理，实现下列的方法
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UITextView *textView = [UITextView new];
    textView.text = @"wazrx";
    textView.font = [UIFont systemFontOfSize:16];
    textView.editable = NO;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(textView.mas_bottom).offset(20);
    }];
    self.interactiveDismiss = [PSInteractiveTransition interactiveTransitionWithTransitionType:PSInteractiveTransitionTypeDismiss GestureDirection:PSInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
}

- (void)dismiss{
    if (_delegate && [_delegate respondsToSelector:@selector(presentedTwoControllerPressedDismiss)]) {
        [_delegate presentedTwoControllerPressedDismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma make - UIViewControllerTransitioningDelegate 方法
/**
 成为相应的代理，实现相应的代理方法，返回我们前两步自定义的对象就OK了 
 模态推送需要实现如下4个代理方法，
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [PSPresentOneTransition transitionWithTransitionType:PSPresentOneTransitionTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [PSPresentOneTransition transitionWithTransitionType:PSPresentOneTransitionTypeDismiss];
}


- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    PSInteractiveTransition *interP = [_delegate interactiveTransitionForPresent];
    return interP.interation ? interP : nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    NSLog(@"销毁了");
}
@end
