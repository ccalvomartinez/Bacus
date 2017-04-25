//
//  CCMWineryModel.h
//  Baccus
//
//  Created by user126733 on 27/3/17.
//  Copyright © 2017 user126733. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CCMWineModel;

@interface CCMWineryModel : NSObject

@property (readonly, nonatomic) NSInteger redWineCount;
@property (readonly,  nonatomic) NSInteger whiteWineCount;
@property (readonly,  nonatomic) NSInteger otherWineCount;

-(CCMWineModel *) redWineAtIndex: (NSInteger) index;
-(CCMWineModel *) whiteWineAtIndex: (NSInteger) index;
-(CCMWineModel *) otherWineAtIndex: (NSInteger) index;

@end
