//
//  DAOTMDB.h
//  TMDB
//
//  Created by Felipe Carrera on 12/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAOTMDB : NSObject


+(id) sharedManager;

-(NSArray *) listSeries;



-(void) saveLocallyTVseries:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError;


@end
