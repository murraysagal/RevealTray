//
//  TrayTransitionAnimator.m
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-20.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import "TrayTransitionAnimator.h"

NSTimeInterval const trayTransitionDuration = 1.0;

@implementation TrayTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return trayTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *trayView = toVC.view;
    UIView *containerView = [transitionContext containerView];

    CGFloat trayWidth = fromView.frame.size.width * 0.9; // trayWidth is how far fromView needs to slide over.
    
    CGFloat trayX = fromView.frame.size.width - trayWidth;
    trayView.frame = CGRectMake(trayX, fromView.frame.origin.y, trayWidth, fromView.frame.size.height);
    [containerView addSubview:trayView];

    CGFloat fromViewXForReveal = fromView.frame.origin.x - trayWidth;
    CGRect fromViewRectForReveal = CGRectMake(fromViewXForReveal, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
    [containerView addSubview:fromView]; // Must be added last so it's on top.

    [UIView animateWithDuration:trayTransitionDuration animations:^{
        fromView.frame = fromViewRectForReveal;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
