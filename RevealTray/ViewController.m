//
//  ViewController.m
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-17.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import "ViewController.h"
#import "TrayTransitionAnimator.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RevealTraySegueIdentifier"]) {
        UIViewController *toVC = segue.destinationViewController;
        toVC.modalPresentationStyle = UIModalPresentationCustom;
        toVC.transitioningDelegate = self;

    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    TrayTransitionAnimator *animator = [[TrayTransitionAnimator alloc] init];
    return animator;
}
@end
