//
//  WCClasses.h
//  FlickrImageGallery
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myComplete)(NSArray *);
typedef void(^fail)(NSError *);

@interface WCClasses : NSObject


+(void)loadFeedByTag:(NSString *)tag complete:(myComplete)block fail:(fail)failBlock;
@end
