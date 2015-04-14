//
//  DetailViewController.m
//  TMDB
//
//  Created by Felipe Carrera on 13/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "constants.h"
#import "DAOTMDB.h"

@implementation DetailViewController
{

    __weak IBOutlet UILabel *titleTM;
    __weak IBOutlet UIImageView *posterTM;
    __weak IBOutlet UITextView *descriptionTM;
    __weak IBOutlet UILabel *seasonsTM;
}

@synthesize selectedSerie = _selectedSerie;


-(void) viewDidLoad
{
    titleTM.text = _selectedSerie.name;
    [posterTM sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WS_IMAGES_PATH, _selectedSerie.poster]]];

    [[DAOTMDB sharedManager] saveMoreInfoOfTVserie:_selectedSerie
                                           success:^{

                                               _selectedSerie = [[DAOTMDB sharedManager] findLocallyTVSeriewithIdentifier:_selectedSerie.identifier];
                                               descriptionTM.text = _selectedSerie.overview;
                                               seasonsTM.text = _selectedSerie.numberSeasons;

                                           }
                                           orError:^(NSError *error){

                                           }];


}

@end
