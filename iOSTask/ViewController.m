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
@synthesize mCollectionView, indicator, indicator1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [indicator stopAnimating];
    products = [[NSMutableArray alloc]init];
    i=1;
    
    NSString *urlString = @"http://grapesnberries.getsandbox.com/products?count=10&from=1";
    [self getDataFromURL:urlString];
    
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
-(void)viewDidAppear:(BOOL)animated
{
    [indicator stopAnimating];
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

//get data from url asynch
-(void)getDataFromURL:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        result = (NSDictionary *)responseObject;
        [self.mCollectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertController *alert=   [UIAlertController alertControllerWithTitle:@"Error" message:@"Error loading data" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    [operation start];
    
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
        for(NSDictionary *dic in result)
        {
            //store products data
            product *prod = [[product alloc]init];
            NSDictionary *imURl = dic[@"image"];
            [prod setPrice:dic[@"price"]];
            [prod setProductDescription:dic[@"productDescription"]];
            [prod setImageHeight:imURl[@"height"]];
            [prod setImageWidth:imURl[@"width"]];
            [prod setImageUrl:imURl[@"url"]];
            [products addObject:prod];
        }
        return [products count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    product *p = [products objectAtIndex:indexPath.row];
    cell.price.text = [NSString stringWithFormat:@"%@",p.price];
    cell.myImage.image = nil;

    [cell.myImage setImageWithURL:[NSURL URLWithString:p.imageUrl] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    cell.productDes.text = p.ProductDescription;
    if(indexPath.row == products.count-1)
    {
        i+=10;
        NSString *preUrlString = @"http://grapesnberries.getsandbox.com/products?count=10&";
        
        NSString *urlString =[NSString stringWithFormat:[preUrlString stringByAppendingString:@"from=%d" ],i];
        [self getDataFromURL:urlString];
        [collectionView numberOfItemsInSection:indexPath.section];
    }
    return cell;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    product *p = [products objectAtIndex:indexPath.row];
    return CGSizeMake(p.imageWidth.floatValue, p.imageHeight.floatValue);
}

@end
