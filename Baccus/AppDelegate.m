//
//  AppDelegate.m
//  Baccus
//
//  Created by user126733 on 24/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "AppDelegate.h"
#import "CCMWineModel.h"
#import "CCMWineViewController.h"
#import "CCMWebViewController.h"
#import "CCMWineryModel.h"
#import "CCMWineryTableViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Creamos el modelo
    CCMWineryModel *winery = [[CCMWineryModel alloc] init];
    
 
    //Asignamos en controlador como controlador raiz
    UIViewController *rootViewController = nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        rootViewController = [self rootViewControllerForPhoneWithModel: winery];
    }else{
        rootViewController = [self rootViewControllerForPadWithModel: winery];
    }
    self.window.rootViewController = rootViewController;
    
    
    self.window.backgroundColor = [UIColor orangeColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(UIViewController*) rootViewControllerForPadWithModel:(CCMWineryModel *) model{
    //Creamos los controladores
    CCMWineryTableViewController *wineryVC = [[CCMWineryTableViewController alloc] initWithModel:model
                                                                                      tableStyle:UITableViewStylePlain];
    CCMWineViewController  *wineVC =  [[CCMWineViewController alloc] initWithModel: [wineryVC lastSelectedWine]];
    
    //Creamos los navigations
    UINavigationController *navWineryVC = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    UINavigationController *navWineVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    //Creamos el combinador (split view)
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[navWineryVC,navWineVC];
    
    
    //asignamos delegados
    wineryVC.delegate = wineVC;
    splitVC.delegate = wineVC;
    
    return splitVC;
}
-(UIViewController *) rootViewControllerForPhoneWithModel:(CCMWineryModel *) model{
    //Creamos los controladores
    CCMWineryTableViewController *wineryVC = [[CCMWineryTableViewController alloc] initWithModel:model
                                                                                      tableStyle:UITableViewStylePlain];
  
    
    //Creamos los navigations
    UINavigationController *navWineryVC = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    //Asignamos delegados
    wineryVC.delegate = wineryVC;
    
    return navWineryVC;

}
@end
