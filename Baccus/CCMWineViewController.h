//
//  CCMWineViewController.h
//  Baccus
//
//  Created by user126733 on 25/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMWineryTableViewController.h"

@class CCMWineModel;


@interface CCMWineViewController : UIViewController <UISplitViewControllerDelegate,WineryTableViewControllerDelegate>
//Propiedades

@property (strong, nonatomic) CCMWineModel  *model;

@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UILabel *winCompanyNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *typeLabel;
@property (weak,nonatomic) IBOutlet UILabel *originLabel;
@property (weak,nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak,nonatomic) IBOutlet UILabel *notesLabel;
@property (weak,nonatomic) IBOutlet UIImageView *photoView;

@property (strong,nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;

//Inicializadores

-(id) initWithNibName: (NSString *) nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil;

-(id) initWithModel: (CCMWineModel *) wineModel;

// Actions

-(IBAction)displayWeb:(id)sender;


@end
