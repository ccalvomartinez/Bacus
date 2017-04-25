//
//  CCMWineModel.m
//  Baccus
//
//  Created by user126733 on 24/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "CCMWineModel.h"

@implementation CCMWineModel

@synthesize photo = _photo;

#pragma mark - Propiedades

-(UIImage *)photo{
    if(_photo == nil){
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoUrl]];
    }
    return  _photo;
}

#pragma mark - Class methods

+(instancetype) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aUrl
             notes: (NSString *) aNotes
            rating: (NSInteger) aRating
          photoUrl:(NSURL *) aPhotoUrl{
    
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aUrl
                                notes:aNotes
                               rating:aRating
                             photoUrl:aPhotoUrl];
}

+(instancetype) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin{
    
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin];

}


#pragma mark - Init

//Designado
-(id) initWithName: (NSString *) aName
  wineCompanyName: (NSString *) aWineCompanyName
             type: (NSString *) aType
           origin:(NSString *) anOrigin
           grapes: (NSArray *) arrayOfGrapes
   wineCompanyWeb: (NSURL *) aUrl
            notes: (NSString *) aNotes
           rating: (NSInteger) aRating
          photoUrl: (NSURL *) aPhotoUrl{
    
    if(self = [super init]){
        _name = aName;
        _wineCompanyName = aWineCompanyName,
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aUrl;
        _notes = aNotes;
        _rating = aRating;
        _photoUrl = aPhotoUrl;
    }
    return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin{
    return [self initWithName:aName
              wineCompanyName:aWineCompanyName
                         type:aType
                       origin:anOrigin
                       grapes:nil
               wineCompanyWeb:nil
                        notes:nil
                       rating:[self CCMNoRating]
                     photoUrl:nil];
}

#pragma mark - JSON
-(id) initWithDictionary: (NSDictionary *) aDict{
return [self initWithName:[aDict objectForKey:@"name"]
          wineCompanyName:[aDict objectForKey:@"company"]
                     type:[aDict objectForKey:@"type"]
                   origin:[aDict objectForKey:@"origin"]
                   grapes:[self extracGrapesForJSONArray:[aDict objectForKey:@"grapes"]]
           wineCompanyWeb:[NSURL URLWithString:[aDict objectForKey:@"company_web"]]
                    notes:[aDict objectForKey:@"notes"]
                   rating:[[aDict objectForKey:@"rating"] intValue]
                 photoUrl:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
}
        

-(NSArray *) extracGrapesForJSONArray: (NSArray *) anArray{
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:anArray.count];
    
    for (NSDictionary *dict in anArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
    
}

-(NSInteger) CCMNoRating{
    return -1;
}

@end
