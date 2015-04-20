//
//  TrayTransitionAnimator.h
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-20.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrayTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;

@end
