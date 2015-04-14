//
//  DAOTMDB.h
//  TMDB
//
//  Created by Felipe Carrera on 12/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVSerie.h"

@interface DAOTMDB : NSObject


+(id) sharedManager;

-(NSArray *) listSeries;
-(TVSerie *) findLocallyTVSeriewithIdentifier:(NSNumber *) identifier;
-(NSArray *) findLocallyTVSeriesByName:(NSString *) name;


-(void) saveLocallyTVseries:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError;
-(void) saveMoreInfoOfTVserie:(TVSerie *) serie success:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError;
-(void) saveLocallyTVseriesFilteredByName:(NSString *) searchKey success:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError;

@end
