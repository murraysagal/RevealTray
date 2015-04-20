//
//  ViewController.m
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-17.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import "ViewController.h"
#import "TrayTransitionAnimator.h"
#import "TrayViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, TrayViewControllerDelegate>

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RevealTraySegueIdentifier"]) {
        TrayViewController *trayViewController = segue.destinationViewController;
        trayViewController.modalPresentationStyle = UIModalPresentationCustom;
        trayViewController.transitioningDelegate = self;
        trayViewController.delegate = self;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    TrayTransitionAnimator *animator = [[TrayTransitionAnimator alloc] init];
    animator.appearing = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    TrayTransitionAnimator *animator = [[TrayTransitionAnimator alloc] init];
    animator.appearing = NO;
    return animator;
}

- (void)trayViewControllerDidFinish:(TrayViewController *)trayViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
