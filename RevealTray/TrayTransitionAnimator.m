//
//  TrayTransitionAnimator.m
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-20.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import "TrayTransitionAnimator.h"

NSTimeInterval const trayTransitionDurationPresent = 1.0;
NSTimeInterval const trayTransitionDurationDismiss = 0.25;

@implementation TrayTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isAppearing) {
        return trayTransitionDurationPresent;
    } else {
        return trayTransitionDurationDismiss;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    UIView *containerView = transitionContext.containerView;

    UIView *trayView;
    CGFloat trayWidth;
    
    if (self.isAppearing) {
        
        trayView = toView; // When appearing toView is the tray.
        trayWidth = fromView.frame.size.width * 0.9; // trayWidth is how far fromView needs to slide.
        CGFloat trayX = fromView.frame.size.width - trayWidth;
        trayView.frame = CGRectMake(trayX, fromView.frame.origin.y, trayWidth, fromView.frame.size.height);
        [containerView addSubview:trayView];
        
        CGFloat fromViewXForReveal = fromView.frame.origin.x - trayWidth;
        CGRect fromViewRectForReveal = CGRectMake(fromViewXForReveal, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        [containerView addSubview:fromView]; // Must be added last so it's on top.
        
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            fromView.frame = fromViewRectForReveal;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        
        trayView = fromView; // When disappearing fromView is the tray.
        trayWidth = trayView.frame.size.width;
        CGRect toViewOriginalFrame = CGRectMake(toView.frame.origin.x + trayWidth, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            toView.frame = toViewOriginalFrame;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [[UIApplication sharedApplication].keyWindow addSubview:toView]; // Because it was added to containerView in the if().
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
