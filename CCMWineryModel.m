//
//  CCMWineryModel.m
//  Baccus
//
//  Created by user126733 on 27/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import "CCMWineryModel.h"
#import "CCMWineModel.h"

@interface CCMWineryModel ()

@property (strong,nonatomic) NSMutableArray *redWines;
@property (strong,nonatomic) NSMutableArray *whiteWines;
@property (strong,nonatomic) NSMutableArray *otherWines;

@end

@implementation CCMWineryModel
#pragma mark - Properties

-(NSInteger) redWineCount{
    return  [self.redWines count];
}

-(NSInteger) whiteWineCount{
    return [self.whiteWines count];
}

-(NSInteger) otherWineCount{
    return [self.otherWines count];
}

#pragma mark - Init
-(id) init{
    if(self = [super init]){
    
        //Creamos el modelo
       
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]];
        NSURLResponse *response =[[NSURLResponse alloc] init];
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        if (data != nil){
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
            if (JSONObjects != nil){
                for(NSDictionary *dict in JSONObjects){
                    CCMWineModel *wine = [[CCMWineModel alloc] initWithDictionary:dict];
                    if ([wine.type  isEqual: [self CCMRedWineType]]){
                        if(self.redWines ==nil){
                            self.redWines =[NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.redWines addObject:wine];
                        }
                    }else if ([wine.type isEqualToString:[self CCMWhiteWineType]]){
                        if(self.whiteWines ==nil){
                            self.whiteWines =[NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.whiteWines addObject:wine];
                        }
                    }else{
                        if(self.otherWines ==nil){
                            self.otherWines =[NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.otherWines addObject:wine];
                        }
                    }
                }
            }else{
                NSLog(@"Ha ocurrido un error al parsear el JSON: %@",error.localizedDescription);
            }
            
        }else{
            NSLog(@"Ha ocurrido un error al obtener el JSON: %@",error.localizedDescription);
        }
        
    }
    return  self;
}

#pragma mark - Utils
-(CCMWineModel *) redWineAtIndex: (NSInteger) index{
    return  [self.redWines objectAtIndex:index];
}
-(CCMWineModel *) whiteWineAtIndex: (NSInteger) index{
    return [self.whiteWines objectAtIndex:index];
}
-(CCMWineModel *) otherWineAtIndex: (NSInteger) index{
    return [self.otherWines objectAtIndex:index];
}

#pragma  mark - Constants

-(NSString *) CCMRedWineType{
    return @"Tinto";
}

-(NSString *) CCMWhiteWineType{
    return @"Blanco";
}

@end
