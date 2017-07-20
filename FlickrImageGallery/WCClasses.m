//
//  WCClasses.m
//  FlickrImageGallery
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import "WCClasses.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "const.h"

@implementation WCClasses



+(void)loadFeedByTag:(NSString *)tag complete:(myComplete)block fail:(fail)failBlock
{
    NSString *urlStr=FEED_URL;
    if ([tag length] != 0) {
        urlStr=[[NSString stringWithFormat:@"%@&tags=%@",urlStr,tag] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        NSString *correctedJSONString = [NSString stringWithString:[responseString substringWithRange:NSMakeRange (15, responseString.length-15-1)]];
        correctedJSONString = [correctedJSONString stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
        
        NSDictionary *dict = [correctedJSONString JSONValue];
        
        block([dict objectForKey:@"items"]);
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        failBlock(error);
    }];
    [request startAsynchronous];
}

@end
