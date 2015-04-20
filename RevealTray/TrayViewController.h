//
//  TrayViewController.h
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-20.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrayViewController;

@protocol TrayViewControllerDelegate <NSObject>

- (void)trayViewControllerDidFinish:(TrayViewController *)trayViewController;

@end

@interface TrayViewController : UIViewController

@property (weak, nonatomic) id<TrayViewControllerDelegate> delegate;

@end
