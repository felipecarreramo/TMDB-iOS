//
//  DetailViewController.h
//  TMDB
//
//  Created by Felipe Carrera on 13/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVSerie.h"

@interface DetailViewController : UIViewController


@property(nonatomic, strong) TVSerie *selectedSerie;

@end
