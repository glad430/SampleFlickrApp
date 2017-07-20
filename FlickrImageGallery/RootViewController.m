//
//  RootViewController.m
//  FlickrImageGallery
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import "RootViewController.h"
#import "WCClasses.h"
#import "ImageCell.h"
#import "const.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _actionSheetClass = [UIActionSheet class];
    self.dataTable.hidden=YES;
    
    [self getDataWithParam:@""];
    
}
// Refresh button method
-(IBAction)refreshBtnClicked:(id)sender
{
    [self getDataWithParam:imageSearchBar.text];
}
// Sorting button method
-(IBAction)sortBtnClicked:(id)sender
{
    NSString *actionSheetTitle = @"Sorting by"; //Action Sheet Title
    NSString *cancelTitle = @"Cancel";
    
    // Allocate _actionSheetClass instead of UIActionSheet.
    UIActionSheet *actionSheet = [(UIActionSheet *)[self.actionSheetClass alloc]
                                  initWithTitle:actionSheetTitle                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:DATE_ASCENDING,DATE_DESCENDING,PUBLISH_ASCENDING,nil];
    [actionSheet addButtonWithTitle:PUBLISH_DESCENDING];
    [actionSheet showInView:[self view]];
    
}

// Actions for the actionsheet which popup after pressing sortButton
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet cancelButtonIndex])
    {
        // cancelled, nothing happen
        return;
    }
    
    NSString *sortType = nil;
    BOOL ascendingOrder;
    // obtain a human-readable option string
    NSString *option = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([option isEqualToString:DATE_ASCENDING])
    {
        //...
        sortType = kDate;
        ascendingOrder = YES;
        
    }
    else if ([option isEqualToString:DATE_DESCENDING])
    {
        //...
        sortType = kDate;
        ascendingOrder = NO;
        
    }
    else if ([option isEqualToString:PUBLISH_ASCENDING])
    {
        //...
        sortType = kPublished;
        ascendingOrder = YES;
    }
    else if ([option isEqualToString:PUBLISH_DESCENDING])
    {
        //...
        sortType = kPublished;
        ascendingOrder = NO;
       
    }
   
     [self updateSortedDataInTheTable:sortType sortingOrder:ascendingOrder];
}

-(void)updateSortedDataInTheTable:(NSString *)sortType sortingOrder:(BOOL)ascendingOrder {
   
    /* Sorting method added to do sorting as per date added 
     and publish in ascending and descending order
     */
    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                      sortDescriptorWithKey:sortType
                      ascending:ascendingOrder];
    dataArray = [dataArray
                 sortedArrayUsingDescriptors:@[dateDescriptor]];
    [self.dataTable reloadData];
}

-(UIView*)getViewForSheetAndPopUp:(UITableViewCell*)cell {
    UIView *accessoryView = cell.accessoryView;
    
    if (accessoryView == nil) {
        UIView *cellContentView = nil;
        
        for (UIView *accView in [cell subviews]) {
            if ([accView isKindOfClass:[UIButton class]]) {
                accessoryView = accView;
                break;
            } else if ([accView isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
                cellContentView = accView;
            }
        }
        
        if (accessoryView == nil) {
            accessoryView   = cellContentView;
        }
        if (accessoryView == nil) {
            accessoryView   = cell;
        }
    }
    
    return accessoryView;
}
// Get data from feed
-(void) getDataWithParam : (NSString *)param
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WCClasses loadFeedByTag:param complete:^(NSArray *data){
        self.dataTable.hidden=NO;
        dataArray = [NSArray arrayWithArray:data];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.dataTable reloadData];
        
        
    }fail:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"cell";
    
    ImageCell *cell = [tableView1 dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSDictionary *dict=[dataArray objectAtIndex:indexPath.row];
    
    
    cell.titleLbl.font=[UIFont fontWithName:@"SFUIDisplay-Bold" size:12*WidthTriangle];
    cell.autherNameLbl.font=[UIFont fontWithName:@"SFUIDisplay-Regular" size:11*WidthTriangle];
    cell.dateLbl.font=[UIFont fontWithName:@"SFUIDisplay-Regular" size:10*WidthTriangle];
    
    // loading the image from URL and adding it to the main image
    NSURL *imageURL = [NSURL URLWithString:[[dict objectForKey:kMedia] objectForKey:@"m"]];
    [cell.mainImg sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@""]];
    
    // After getting values from server, get the values for title,author and date from dictonary
    cell.titleLbl.text=[dict objectForKey:kTitle];
    cell.autherNameLbl.text=[NSString stringWithFormat:@"By %@",[dict objectForKey:kAuthor]];
    cell.dateLbl.text= [NSString stringWithFormat:@"Publish at: %@ • Taken at: %@",[self getFormattedDate:[dict objectForKey:kPublished]], [self getFormattedDate:[dict objectForKey:kDate]]];
    
    
    cell.moreBtn.tag=  indexPath.row;
    [cell.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[dataArray objectAtIndex:indexPath.row];
    float height = [self getHeightForText:[dict objectForKey:kTitle]];
    return (145*WidthTriangle)+height+65*WidthTriangle;
}

// Get height for Title
- (float)getHeightForText:(NSString *)text
{
    CGSize constrainedSize = CGSizeMake(290*WidthTriangle  , 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"SFUIDisplay-Bold" size:11*WidthTriangle], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return requiredHeight.size.height;
}

// More button actions clicked from the UItableView Cell and call this method in action sheet
-(void)moreBtnClicked:(UIButton *) btn
{
    NSDictionary *dict=[dataArray objectAtIndex:btn.tag];
    
    // Created actionsheet for three buttons for sharing activities
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Image Gallery" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // sharing image by mail
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Share in mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            
            [mailCont setSubject:@"Image"];
            
            [mailCont setMessageBody:@"Hi," isHTML:NO];
            [mailCont addAttachmentData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[dict objectForKey:kMedia] objectForKey:@"m"]]] mimeType:@"image/jpeg" fileName:@"image"];
            
            [self presentViewController:mailCont animated:YES completion:nil];
            
        }
        
        
    }]];
    
    // open image in browser
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Open in browser" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict valueForKey:kLink]]];
        
    }]];
    
    // save image to gallery
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Save to gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[dict objectForKey:kMedia] objectForKey:@"m"]]];
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Gallery" message:@"Image save successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self doSomethingWithRowAtIndexPath:indexPath];
    
}

// Get formatted date
-(NSString *)getFormattedDate:(NSString *)dateStr
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date  = [dateFormatter dateFromString:dateStr];
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}


// Then implement the delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Search bar search button method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self getDataWithParam:searchBar.text];
    [searchBar resignFirstResponder];
}
// Search bar cancel button method
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text=@"";
    [self getDataWithParam:searchBar.text];
    [searchBar resignFirstResponder];
}

@end
