//
//  network.m
//  iOSTask
//
//  Created by mahmoud gamal on 10/29/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import "network.h"

@implementation network
-(void)getDataFromURL:(NSString*)urlString block:(Completion)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result = (NSDictionary *)responseObject;
        if(block)
            block(result,nil);
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(block)
            block(nil, error);
    }];
    [operation start];
}
-(NSMutableArray *)parseJson:(NSDictionary *)result
{
    NSMutableArray *products = [[NSMutableArray alloc]init];
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
    return products;
}
@end
