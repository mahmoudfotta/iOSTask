//
//  CollectionViewCell.h
//  iOSTask
//
//  Created by mahmoud gamal on 10/25/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak,nonatomic) IBOutlet UILabel *price, *productDes;
@property (weak,nonatomic) IBOutlet UIImageView *myImage;
@end
