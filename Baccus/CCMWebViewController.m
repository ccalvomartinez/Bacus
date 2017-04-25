//
//  CCMWebViewController.m
//  Baccus
//
//  Created by user126733 on 26/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "CCMWebViewController.h"
#import "CCMWineModel.h"
#import "CCMWineryTableViewController.h"

@interface CCMWebViewController ()

@end

@implementation CCMWebViewController

-(id) initWtihModel: (CCMWineModel *) aWine{
    
    if(self =[super initWithNibName:nil bundle:nil]){
        _model=aWine;
        
        [self setTitle:@"Web"];
    }
    return self;
}
-(void) wineDidChange: (NSNotification *) notification{
    NSDictionary *dict = notification.userInfo;
    CCMWineModel *newWine = [dict objectForKey:[CCMWineryTableViewController CCMWineKey]];
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view from its nib.
    
    [self displayURL: self.model.wineCompanyWeb];
    
    //Alta notificaciones
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:[CCMWineryTableViewController CCMNewWineNotificationName]
                 object:nil];
}



-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Baja notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Utils

-(void) displayURL: (NSURL *) aUrl{
    //Asignar el delegado al browser
    self.browser.delegate = self;
    
    self.activity.hidden = NO;
    [self.activity startAnimating];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:aUrl]];
}

#pragma mark - UIWebViewDelegate

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    [self.activity setHidden:YES];
    
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
