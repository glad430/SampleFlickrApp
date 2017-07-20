//
//  RootViewController.h
//  FlickrImageGallery
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface RootViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate,UIActionSheetDelegate>
{
    
    NSArray *dataArray;
    IBOutlet UISearchBar *imageSearchBar;
    IBOutlet UIBarButtonItem *refreshBtn;
    IBOutlet UIBarButtonItem *sortBtn;
    
}

@property (nonatomic, strong) IBOutlet UITableView *dataTable;
-(IBAction)refreshBtnClicked:(id)sender;
-(IBAction)sortBtnClicked:(id)sender;
-(UIView*)getViewForSheetAndPopUp:(UITableViewCell*)cell;
-(void) getDataWithParam : (NSString *)param;
@end
