//
//  network.h
//  iOSTask
//
//  Created by mahmoud gamal on 10/29/15.
//  Copyright © 2015 mahmoud gamal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "product.h"
typedef void (^Completion)(NSDictionary * resultD, NSError *error);

@interface network : NSObject
-(void)getDataFromURL:(NSString*)urlString block:(Completion)block;
-(product *)parseJson:(NSDictionary *)result;
@end
