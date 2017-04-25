//
//  CCMWineryTableViewController.m
//  Baccus
//
//  Created by user126733 on 27/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "CCMWineryTableViewController.h"
#import "CCMWineViewController.h"
#import "CCMWineryModel.h"
#import "CCMWineModel.h"

@interface CCMWineryTableViewController ()

@end

@implementation CCMWineryTableViewController

#pragma mark - Init

-(id) initWithModel:(CCMWineryModel *) aModel
         tableStyle:(UITableViewStyle) style{
    if(self = [super initWithStyle:style]){
        _model = aModel;
        self.title = @"Baccus";
    }
    return self;
}

#pragma mark - View delegate
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout =UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    self.navigationController.navigationBar.barTintColor= [UIColor colorWithRed:0.5
                                                                          green:0
                                                                           blue:0.13
                                                                          alpha:1];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Suponemos que estamos en un NavigationController
    //Averiguamos de qué vino se trata
       CCMWineModel *wine = [self wineForIndexPath:indexPath];
    
   
    
    [self.delegate wineryTableViewController:self
                               didSelectWine:wine];
    
    //Crear notificacon
    NSNotification *n = [NSNotification notificationWithName:[CCMWineryTableViewController CCMNewWineNotificationName]
                                                      object:self
                                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:wine,[CCMWineryTableViewController CCMWineKey], nil]];
    //Enviar notificación
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    //Guardar UserDefaults
    [self saveLastWineWithSection:indexPath.section andRow: indexPath.row];
}

#pragma mark - Table view data source

-(NSString *) tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    if(section == [CCMWineryTableViewController CCMRedWineSection]){
        return @"Vinos tintos";
    }else if(section == [CCMWineryTableViewController CCMWhiteWineSection]){
        return @"Vinos blancos";
    }else{
        return @"Otros vinos";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == [CCMWineryTableViewController CCMRedWineSection]){
        return self.model.redWineCount;
    }
    else if (section == [CCMWineryTableViewController CCMWhiteWineSection]){
        return self.model.whiteWineCount;
    }
    else{
        return self.model.otherWineCount;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //Obtener el modelo correspondiente a la celda
    
    CCMWineModel *wine = [self wineForIndexPath:indexPath];
    
    //Sincronizar celda (vista) y modelo (vino)
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    return cell;
}

#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController:(CCMWineryTableViewController *)wineryVC
                    didSelectWine:(CCMWineModel *)aWine{
    CCMWineViewController *wineVC = [[CCMWineViewController alloc] initWithModel:aWine];
    [self.navigationController pushViewController:wineVC
                                         animated:YES];
}

#pragma mark - NSDefaults

-(void) saveLastWineWithSection:(NSUInteger) section andRow: (NSUInteger) row{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:
     [NSDictionary dictionaryWithObjectsAndKeys:
      @(section),[CCMWineryTableViewController CCMSectionKey],
      @(row),[CCMWineryTableViewController CCMRowKey], nil]
                     forKey:[CCMWineryTableViewController CCMLastWineKey]];
    [userDefaults synchronize];
}

-(CCMWineModel *) wineForIndexPath:(NSIndexPath *) indexPath{
    if(indexPath.section == 0){
        if(indexPath.row >= self.model.redWineCount){
            return nil;
        }
        else{
            return [self.model redWineAtIndex:indexPath.row];
        }
    }else if(indexPath.section == 1){
        if(indexPath.row >= self.model.whiteWineCount){
            return nil;
        }
        else{
            return [self.model whiteWineAtIndex:indexPath.row];
        }
    }
    else{
        if(indexPath.row >= self.model.otherWineCount){
            return nil;
        }
        else{
            return [self.model otherWineAtIndex:indexPath.row];
        }
    }

}

-(NSDictionary *) setDefaults{
    NSDictionary *coord = [NSDictionary dictionaryWithObjectsAndKeys:@0,[CCMWineryTableViewController CCMRowKey],@0,[CCMWineryTableViewController CCMSectionKey], nil];
    
    //Obtener UserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //asignamos User Defaults
    [userDefaults setObject:coord
                     forKey:[CCMWineryTableViewController CCMLastWineKey]];
    //Guardar
    [userDefaults synchronize];
    
    return  coord;
}

-(CCMWineModel *) lastSelectedWine{
    NSIndexPath *indexPath = nil;
    NSDictionary *coord = nil;
    
    coord = [[NSUserDefaults standardUserDefaults] objectForKey:[CCMWineryTableViewController CCMLastWineKey]];
    if(coord == nil){
        coord = [self setDefaults];
    }
    indexPath = [NSIndexPath indexPathForRow:[[coord objectForKey:[CCMWineryTableViewController CCMRowKey]] integerValue]
                                    inSection:[[coord objectForKey:[CCMWineryTableViewController CCMSectionKey]] integerValue]];
    
    return  [self wineForIndexPath:indexPath];
}

#pragma mark - Constant

//Wine sections
+(NSInteger) CCMRedWineSection{
    return 0;
}

+(NSInteger) CCMWhiteWineSection{
    return 1;
}

+(NSInteger) CCMOtherWineSection{
    return 2;
}

//Notifications
+(NSString *) CCMNewWineNotificationName{
    return @"newWine";
}

+(NSString *) CCMWineKey{
    return @"wine";
}

//Last wine
+(NSString *) CCMLastWineKey{
    return @"lastWineCoordinates";
}

+(NSString *) CCMRowKey{
    return @"row";
}
+(NSString *) CCMSectionKey{
    return @"section";
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
