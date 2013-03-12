//
//  exampleAppDelegate.h
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright 2013 IGR Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class exampleViewController;

@interface exampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    exampleViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet exampleViewController *viewController;

@end

