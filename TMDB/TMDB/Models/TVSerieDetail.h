//
//  TVSerieDetail.h
//  TMDB
//
//  Created by Mobile Developer on 14/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TVSerie;

@interface TVSerieDetail : NSManagedObject

@property (nonatomic, retain) NSString * numberSeasons;
@property (nonatomic, retain) NSString * overview;
@property (nonatomic, retain) TVSerie *tvserie;

@end
