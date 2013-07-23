//
//  AppDelegate.h
//  dragMe
//
//  Created by Foram Mukund Shah on 12/6/12.
//

#import <UIKit/UIKit.h>

@class dragViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) dragViewController *dviewController;

@end
