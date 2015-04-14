//
//  TVSerie.h
//  TMDB
//
//  Created by Mobile Developer on 14/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TVSerieDetail;

@interface TVSerie : NSManagedObject

@property (nonatomic, retain) NSString * cover;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * numberSeasons;
@property (nonatomic, retain) NSString * overview;
@property (nonatomic, retain) NSString * poster;
@property (nonatomic, retain) TVSerieDetail *tvSerieDetail;

@end
