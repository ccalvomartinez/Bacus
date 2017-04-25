//
//  CCMWebViewController.h
//  Baccus
//
//  Created by user126733 on 26/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCMWineModel;

@interface CCMWebViewController : UIViewController <UIWebViewDelegate>

@property (strong,nonatomic) CCMWineModel *model;
@property (weak,nonatomic) IBOutlet UIWebView *browser;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *activity;

-(id) initWtihModel: (CCMWineModel *) aWine;

@end
