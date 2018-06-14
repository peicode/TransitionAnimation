//
//  PSPresentOneController.m
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "PSPresentOneController.h"
#import "PSInteractiveTransition.h"
#import "PSPresentOneTransition.h"
#import "PSPresentTwoController.h"
#import "Masonry.h"
@interface PSPresentOneController ()<PSPresentTwoControllerDelegate>
@property(nonatomic,strong)PSInteractiveTransition *interactivePush;
@end

@implementation PSPresentOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lol"]];
    iconView.layer.cornerRadius = 10;
    iconView.layer.masksToBounds = YES;
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者向上滑动" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(iconView.mas_bottom).offset(30);
    }];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    _interactivePush = [PSInteractiveTransition interactiveTransitionWithTransitionType:PSInteractiveTransitionTypePresent GestureDirection:PSInteractiveTransitionGestureDirectionUp];
    typeof(self)weakSelf = self;
    _interactivePush.presentConfig = ^{
        [weakSelf present];
    };
    [_interactivePush addPanGestureForViewController:self.navigationController];
    
}

- (void)present{
    PSPresentTwoController *presentedVC = [PSPresentTwoController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentedTwoControllerPressedDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
}

@end
