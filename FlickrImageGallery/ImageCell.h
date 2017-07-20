//
//  ImageCell.h
//  FlickrImageGallery
//
//  Created by Creative Infoway on 18/07/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView *mainImg;
@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *autherNameLbl;
@property (nonatomic,retain) IBOutlet UILabel *dateLbl;
@property (nonatomic,retain) IBOutlet UIButton *moreBtn;


@end
