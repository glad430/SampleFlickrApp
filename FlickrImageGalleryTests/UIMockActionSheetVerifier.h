//
//  UIMockActionSheetVerifier.h
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
    Captures UIMockActionSheet arguments.
 */
@interface UIMockActionSheetVerifier : NSObject

@property (nonatomic, assign) NSUInteger showCount;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;

- (id)init;

@end
