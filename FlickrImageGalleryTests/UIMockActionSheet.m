//
//  UIMockActionSheet
//  FlickrImageGallery
//
//  Created by Abdul  on 20/07/2017.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import "UIMockActionSheet.h"

NSString *const UIMockActionSheetShowNotification = @"UIMockActionSheetShowNotification";


@implementation UIMockActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id <UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _delegate = delegate;
        _cancelButtonTitle = [cancelButtonTitle copy];
        _destructiveButtonTitle = [destructiveButtonTitle copy];
        
        _otherButtonTitles = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = va_arg(args, NSString *))
            [_otherButtonTitles addObject:otherTitle];
        va_end(args);
    }
    return self;
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    [self.otherButtonTitles addObject:title];
    return self.otherButtonTitles.count;
}

- (void)showInView:(UIView *)view
{
    self.parentView = view;
    // Test buttons on the view
    [[NSNotificationCenter defaultCenter] postNotificationName:UIMockActionSheetShowNotification
                                                        object:self
                                                      userInfo:nil];
}

@end
