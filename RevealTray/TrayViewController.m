//
//  TrayViewController.m
//  RevealTray
//
//  Created by Murray Sagal on 2015-04-20.
//  Copyright (c) 2015 Murray Sagal. All rights reserved.
//

#import "TrayViewController.h"

@interface TrayViewController ()

@end

@implementation TrayViewController

- (IBAction)dismissTray {
    [self.delegate trayViewControllerDidFinish:self];
}

@end
