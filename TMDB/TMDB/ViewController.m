//
//  ViewController.m
//  TMDB
//
//  Created by Mobile Developer on 10/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import "ViewController.h"
#import "TVSerie.h"
#import "DAOTMDB.h"
#import "TMViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "constants.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *series;
    __weak IBOutlet UICollectionView *collection;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[DAOTMDB sharedManager] saveLocallyTVseries:^{

                                                    series = [[DAOTMDB sharedManager] listSeries];
                                    [collection reloadData];

                                        }
                                         orError:^(NSError *error)   {

                                         }];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return series.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TMView" forIndexPath:indexPath];
    TVSerie *serie = [series objectAtIndex:indexPath.row];

    cell.titleTM.text = serie.name;
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",WS_IMAGES_PATH,serie.poster];
    NSLog(@"image %@", imagePath);

    NSLog(@"cell %@", cell.posterTM);
    //cell.posterTM.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
    [cell.posterTM sd_setImageWithURL:[NSURL URLWithString:imagePath]];

    return cell;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
