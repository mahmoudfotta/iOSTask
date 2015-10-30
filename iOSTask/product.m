//
//  product.m
//  iOSTask
//
//  Created by mahmoud gamal on 10/27/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import "product.h"
@interface product()
{
    NSNumber *imageHeight, *imageWidth;
    NSString *productDescription, *imageUrl;
    NSNumber * price;
}
@end
@implementation product

-(void)setPrice:(NSNumber *)pric
{
    price = pric;
}
-(NSNumber *)price
{
    return price;
}
-(void)setImageHeight:(NSNumber *)height
{
    imageHeight = height;
}
-(NSNumber *)imageHeight
{
    return imageHeight;
}

-(void)setImageWidth:(NSNumber *)width
{
    imageWidth = width;
}
-(NSNumber *)imageWidth
{
    return imageWidth;
}

-(void)setProductDescription:(NSString *)productDescriptio
{
    productDescription = productDescriptio;
}
-(NSString *)ProductDescription
{
    return productDescription;
}

-(void)setImageUrl:(NSString *)url
{
    imageUrl = url;
}
-(NSString *)imageUrl
{
    return imageUrl;
}
@end
