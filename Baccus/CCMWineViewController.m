//
//  CCMWineViewController.m
//  Baccus
//
//  Created by user126733 on 25/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "CCMWineViewController.h"
#import "CCMWebViewController.h"
#import "CCMWineModel.h"

@implementation CCMWineViewController

#pragma  mark - Init

-(id) initWithNibName: (NSString *) nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    
    }
    return  self;
}

-(id) initWithModel: (CCMWineModel *) wineModel{
    if(self = [super initWithNibName:nil bundle:nil]){
        _model = wineModel;
        
    
    }
    return self;
}

#pragma mark - Delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//sincronizamos modelo y vista
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
    self.edgesForExtendedLayout =UIRectEdgeNone;
   [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
     self.navigationController.navigationBar.barTintColor= [UIColor colorWithRed:0.5
                                                                        green:0
                                                                       blue:0.13
                                                                    alpha:1];
    if(self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Actions

-(IBAction)displayWeb:(id)sender{
   //Crear MVC
    CCMWebViewController *webVC = [[CCMWebViewController alloc] initWtihModel:self.model];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

-(void) syncModelWithView{
    self.nameLabel.text=self.model.name;
    self.winCompanyNameLabel.text = self.model.wineCompanyName;
    self.originLabel.text = self.model.origin;
    self.typeLabel.text = self.model.type;
    self.notesLabel.text = self.model.notes;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes];
    
    [self displayRating: self.model.rating];
    
    [self.notesLabel setNumberOfLines:0];
    
    [self setTitle:self.model.name];
}

-(void) displayRating: (NSInteger) aRating{
    [self clearRating];
    
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass"];
    
    for(int i = 0; i < aRating; i++){
        [[self.ratingViews objectAtIndex:i] setImage:glass];
    }
}

-(void) clearRating{
    for(UIImageView *imgView in self.ratingViews){
        imgView.image=nil;
    }
}
-(NSString *) arrayToString: (NSArray *) anArray{
    
    NSString *repr = nil;
    
    if([anArray count] == 1){
        repr = [@"100% " stringByAppendingString:[anArray lastObject]];
    }else{
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}
#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController:(CCMWineryTableViewController *)wineryVC
                    didSelectWine:(CCMWineModel *)aWine{
    self.model = aWine;
    [self syncModelWithView];
}

#pragma mark    - SplitViewController
-(void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
