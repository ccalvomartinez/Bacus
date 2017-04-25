//
//  CCMWineModel.h
//  Baccus
//
//  Created by user126733 on 24/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define NO_RATING -1

@interface CCMWineModel : NSObject

@property (copy,nonatomic) NSString *type;
@property (readonly,strong,nonatomic) UIImage *photo;
@property (strong,nonatomic) NSURL *photoUrl;
@property (strong,nonatomic) NSURL *wineCompanyWeb;
@property (copy,nonatomic) NSString *notes;
@property (copy,nonatomic) NSString *origin;
@property (nonatomic) NSInteger rating; //0-5
@property (strong,nonatomic) NSArray *grapes;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *wineCompanyName;

//Métodos de clase

+(instancetype) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aUrl
             notes: (NSString *) aNotes
            rating: (NSInteger) aRating
          photoUrl: (NSURL *) aPhotoUrl;

+(instancetype) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin;

//Designado
-(id) initWithName: (NSString *) aName
  wineCompanyName: (NSString *) aWineCompanyName
             type: (NSString *) aType
           origin:(NSString *) anOrigin
           grapes: (NSArray *) arrayOfGrapes
   wineCompanyWeb: (NSURL *) aUrl
            notes: (NSString *) aNotes
           rating: (NSInteger) aRating
          photoUrl: (NSURL *) aPhotoUrl;


-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin;

-(id) initWithDictionary: (NSDictionary *) aDict;

@end
