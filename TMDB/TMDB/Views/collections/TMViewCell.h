//
//  TMViewCell.h
//  TMDB
//
//  Created by Felipe Carrera on 13/04/15.
//  Copyright (c) 2015 Juan Carrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterTM;
@property (weak, nonatomic) IBOutlet UILabel *titleTM;

@end
