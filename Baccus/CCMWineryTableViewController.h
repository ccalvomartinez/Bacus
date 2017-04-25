//
//  CCMWineryTableViewController.h
//  Baccus
//
//  Created by user126733 on 27/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCMWineryModel;
@class CCMWineModel;


@class CCMWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController: (CCMWineryTableViewController *) wineryVC didSelectWine: (CCMWineModel *) aWine;

@end

@interface  CCMWineryTableViewController: UITableViewController <WineryTableViewControllerDelegate>

@property (strong,nonatomic) CCMWineryModel *model;
@property (weak,nonatomic) id<WineryTableViewControllerDelegate> delegate;


+(NSString *) CCMNewWineNotificationName;
+(NSString *) CCMWineKey;


-(id) initWithModel:(CCMWineryModel *) aModel
         tableStyle:(UITableViewStyle) style;

-(CCMWineModel *) lastSelectedWine;

@end

