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
#import "DetailViewController.h"

@interface ViewController ()<UITextFieldDelegate>

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
    [cell.posterTM sd_setImageWithURL:[NSURL URLWithString:imagePath]];

    return cell;

}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:[series objectAtIndex:indexPath.row]];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        DetailViewController *detail = [segue destinationViewController];
        detail.selectedSerie = sender;

    }
}
- (IBAction)onChangeValueOfSearch:(UITextField *)sender
{
    if (sender.text.length > 3)
    {
        [[DAOTMDB sharedManager] saveLocallyTVseriesFilteredByName:sender.text
                                                           success:^{

                                                               series = [[DAOTMDB sharedManager] findLocallyTVSeriesByName:sender.text];
                                                               [collection reloadData];
                                                           }
                                                           orError:^(NSError *error){

                                                           }];
    }

    if (sender.text.length == 0)
    {
        series = [[DAOTMDB sharedManager] listSeries];
        [collection reloadData];
    }


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
