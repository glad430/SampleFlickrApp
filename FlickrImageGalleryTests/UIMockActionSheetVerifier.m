//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import "UIMockActionSheetVerifier.h"

#import "UIMockActionSheet.h"


@implementation UIMockActionSheetVerifier

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(actionSheetShown:)
                                                     name:UIMockActionSheetShowNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)actionSheetShown:(NSNotification *)notification
{
    UIMockActionSheet *alert = [notification object];
	++_showCount;
	self.parentView = alert.parentView;
	self.title = alert.title;
	self.delegate = alert.delegate;
	self.cancelButtonTitle = alert.cancelButtonTitle;
	self.destructiveButtonTitle = alert.destructiveButtonTitle;
    self.otherButtonTitles = alert.otherButtonTitles;
}

@end
