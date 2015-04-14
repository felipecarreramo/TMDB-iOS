//
//  DAOTMDB.m
//  TMDB
//
//  Created by Felipe Carrera on 12/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import "DAOTMDB.h"
#import <RestKit/RestKit.h>
#import "constants.h"

@implementation DAOTMDB


+ (id)sharedManager
{
    static DAOTMDB *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(NSArray *) listSeries
{
    NSManagedObjectContext *context = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TVSerie"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

-(void) saveLocallyTVseries:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError
{

    [[RKObjectManager sharedManager] getObjectsAtPath:@"tv/popular"
                                           parameters:@{@"api_key":WS_API_KEY}
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  onSuccess();
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  onError(error);
                                              }];
}

-(void) saveMoreInfoOfTVserie:(TVSerie *) serie success:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError
{

    [[[RKObjectManager sharedManager] HTTPClient] getPath:[NSString stringWithFormat:@"%@tv/%@", WS_BASE_PATH, serie.identifier]
                                               parameters:@{@"api_key":WS_API_KEY}
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                  {
                                                      serie.overview = [responseObject objectForKey:@"overview"];
                                                      serie.numberSeasons = [NSString stringWithFormat:@"%@ temporadas", [responseObject objectForKey:@"number_of_seasons"]];
                                                      onSuccess();

                                                  }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      onError(error);
                                                  }];

}


-(void) saveLocallyTVseriesFilteredByName:(NSString *) searchKey success:(void(^)(void)) onSuccess orError:(void(^)(NSError *)) onError
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"search/tv"
                                           parameters:@{@"api_key":WS_API_KEY, @"query": searchKey }
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  onSuccess();
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  onError(error);
                                              }];
}


-(NSArray *) findLocallyTVSeriesByName:(NSString *) name
{

    NSManagedObjectContext *context = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TVSerie"];
    NSPredicate *pr = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", name];
    [request setPredicate:pr];
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}


-(TVSerie *) findLocallyTVSeriewithIdentifier:(NSNumber *) identifier
{

    NSManagedObjectContext *context = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TVSerie"];
    NSPredicate *pr = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    [request setPredicate:pr];
    NSError *error;
    return [[context executeFetchRequest:request error:&error] objectAtIndex:0];
}

@end
