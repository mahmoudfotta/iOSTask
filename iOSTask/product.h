//
//  product.h
//  iOSTask
//
//  Created by mahmoud gamal on 10/27/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface product : NSObject
{
    
}
-(void)setPrice:(NSNumber *)price;
-(NSNumber *)price;

-(void)setImageHeight:(NSNumber *)height;
-(NSNumber *)imageHeight;

-(void)setImageWidth:(NSNumber *)width;
-(NSNumber *)imageWidth;

-(void)setProductDescription:(NSString *)productDescription;
-(NSString *)ProductDescription;

-(void)setImageUrl:(NSString *)url;
-(NSString *)imageUrl;
@end
