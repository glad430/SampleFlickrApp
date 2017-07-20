//
//  const.h
//  FlickrImageGallery
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#ifndef const_h
#define const_h

#define FEED_URL @"https://api.flickr.com/services/feeds/photos_public.gne?format=json"

#define kTitle @"title"
#define kLink @"link"
#define kMedia @"media"
#define kDate @"date_taken"
#define kDescription @"description"
#define kPublished @"published"
#define kAuthor @"author"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define     WidthTriangle                               ScreenWidth/320
#define     heightTriangle                              ScreenHeight/568

#endif /* const_h */
