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

#define DATE_ASCENDING  @"Order by date taken ascending"
#define DATE_DESCENDING  @"Order by date taken descending"
#define PUBLISH_ASCENDING  @"Order by publish ascending"
#define PUBLISH_DESCENDING  @"Order by publish descending"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define     WidthTriangle                               ScreenWidth/320
#define     heightTriangle                              ScreenHeight/568

#endif /* const_h */
