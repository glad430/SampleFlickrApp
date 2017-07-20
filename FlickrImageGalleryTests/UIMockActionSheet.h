//
//  ViewControllerTest.m
//  FlickrImageGallery
//
//  Created by Abdul  on 20/07/2017.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const UIMockActionSheetShowNotification;


/**
    Inject this class in place of the UIActionSheet class.
    Instantiate a UIMockActionSheetVerifier before the execution phase of your test.
 */
@interface UIMockActionSheet : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, strong) NSMutableArray *otherButtonTitles;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, assign) UIActionSheetStyle actionSheetStyle;

- (id)initWithTitle:(NSString *)title delegate:(id <UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
- (NSInteger)addButtonWithTitle:(NSString *)title;    // returns index of button. 0 based.
- (void)showInView:(UIView *)view;

@end
