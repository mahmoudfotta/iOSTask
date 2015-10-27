//
//  ViewController.h
//  iOSTask
//
//  Created by mahmoud gamal on 10/25/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CollectionViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "product.h"
#import "UIImageView+AFNetworking.h"
@interface ViewController : UIViewController<UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
{
    NSDictionary *result;
    NSMutableArray *products;
    int i;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
-(void)getDataFromURL:(NSString*)urlString;
@end

