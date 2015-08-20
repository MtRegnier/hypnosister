//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Dane on 8/17/15.
//  Copyright (c) 2015 Regnier Design. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"

@interface AppDelegate () <UIScrollViewDelegate>

@property (nonatomic, weak) BNRHypnosisView *hypnosisSubview;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // Setting up UIScrollView
    
    // CGRects for frames
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    // Commented out for panning and paging
    bigRect.size.height *= 2.0;
    
    // Creating scroll view and adding it to the window
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.pagingEnabled = NO;
    [self.window addSubview:scrollView];
    
    // Let the scroll view know how large its content area is
    scrollView.contentSize = bigRect.size;
    
    // Set the limits on zooming in and out here (check docs for details)
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 2.0;
    
    // Setting the delegate for scrollView
    scrollView.delegate = self;
    
    // Create large hypnosis view and add it to the scroll view
    // Swap this out for the property setter instead
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [self setHypnosisSubview:hypnosisView];
    
    [scrollView addSubview:self.hypnosisSubview];
    
    // Second hypnosis view to the right
    screenRect.origin.x += screenRect.size.width;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSLog(@"Hello");
    return YES;
}

// Implement viewForZoomingInScrollView: here, returns BNRHypnosisView
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.hypnosisSubview;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
