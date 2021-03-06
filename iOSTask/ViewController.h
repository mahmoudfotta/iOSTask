//
//  ViewController.h
//  iOSTask
//
//  Created by mahmoud gamal on 10/25/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "network.h"
#import "CollectionViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "product.h"
#import "AFNetworking+ImageActivityIndicator.h"

@interface ViewController : UIViewController<UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property NSDictionary *result;
@property network *net;
@property int i;
@property NSMutableArray *products;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property CGSize expectedLabelSize;
@property UIActivityIndicatorView *indicator;
- (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(NSString *)fontName fontSize:(float)fontSize;
@end

