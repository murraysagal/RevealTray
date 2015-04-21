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

- (IBAction)revealTrayWithPresent {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TrayViewController *trayViewController = [storyboard instantiateViewControllerWithIdentifier:@"TrayViewControllerStoryboardID"];
    
    // See the comments below in prepareForSegue.
    trayViewController.modalPresentationStyle = UIModalPresentationCustom;
    trayViewController.transitioningDelegate = self;
    trayViewController.delegate = self;
    [self presentViewController:trayViewController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RevealTraySegueIdentifier"]) {
        TrayViewController *trayViewController = segue.destinationViewController;
        
        // With a custom presentation the 'from' view controller (this one) remains
        // in the view hierarchy when the transition completes and that's what is
        // required in this case.
        trayViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        // The 'to' view controller, the tray in this case, must have a transitioning
        // delegate. That delegate must vend the animator object which conforms to
        // the UIViewControllerAnimatedTransitioning protocol. This view controller
        // is that delegate. See below.
        trayViewController.transitioningDelegate = self;
        
        // The TrayViewControllerDelegate protocol is there to allow the tray to notify
        // this view controller that it should be dismissed. See below.
        trayViewController.delegate = self;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

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

#pragma mark - TrayViewControllerDelegate

- (void)trayViewControllerDidFinish:(TrayViewController *)trayViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
