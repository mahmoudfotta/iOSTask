//
//  ViewController.m
//  iOSTask
//
//  Created by mahmoud gamal on 10/25/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mCollectionView, indicator, result ,products, i, expectedLabelSize, net;

- (void)viewDidLoad {
    [super viewDidLoad];
    [indicator stopAnimating];
    products = [[NSMutableArray alloc]init];
    i=1;
    NSString *urlString = @"http://grapesnberries.getsandbox.com/products?count=10&from=1";
    net = [[network alloc]init];
    [net getDataFromURL:urlString block:^(NSDictionary *resultD, NSError *error) {
        if (!error) {
            result = resultD;
            [mCollectionView reloadData];
            [indicator stopAnimating];
        }
        else
        {
            UIAlertController *alert=   [UIAlertController alertControllerWithTitle:@"Error" message:@"Error loading data" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    //setup the custom uicollectionview layout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 0;
    layout.footerHeight = 0;
    layout.minimumColumnSpacing = 5;
    layout.minimumInteritemSpacing=20;
    layout.minimumInteritemSpacing = 30;
    mCollectionView.collectionViewLayout = layout;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:indicator];
    [indicator startAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.mCollectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!result) {
        return 0;
    }
    else
    {
        NSArray *arr = [[net parseJson:result] copy];
        [products addObjectsFromArray:arr];
        return [products count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    product *p = [products objectAtIndex:indexPath.row];
    expectedLabelSize = [self getSizeForText:p.ProductDescription maxWidth:500 font:@"System" fontSize:17.0f];
    [cell.productDes setFrame:CGRectMake(cell.productDes.frame.origin.x, cell.productDes.frame.origin.y, expectedLabelSize.height, expectedLabelSize.width)];
    cell.productDes.text = p.ProductDescription;
    cell.price.text = [NSString stringWithFormat:@"%@",p.price];
    cell.myImage.image = nil;

    [cell.myImage setImageWithURL:[NSURL URLWithString:p.imageUrl] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if(indexPath.row == products.count-1)
    {
        i+=10;
        NSString *preUrlString = @"http://grapesnberries.getsandbox.com/products?count=10&";
        
        NSString *urlString =[NSString stringWithFormat:[preUrlString stringByAppendingString:@"from=%d" ],i];
        [net getDataFromURL:urlString block:^(NSDictionary *resultD, NSError *error) {
            if (!error) {
                result = resultD;
                [mCollectionView reloadData];
            }
        }];
        [collectionView numberOfItemsInSection:indexPath.section];
    }
    return cell;
}

// get the size of atext
- (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(NSString *)fontName fontSize:(float)fontSize {
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    constraintSize.width = width;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:fontName size:fontSize], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize stringSize = frame.size;
    return stringSize;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    product *p = [products objectAtIndex:indexPath.row];
    return CGSizeMake(p.imageWidth.floatValue, p.imageHeight.floatValue+expectedLabelSize.height);
}

@end
