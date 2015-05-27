//
//  LIstViewController.m
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize photos =_photos;
@synthesize pendingOperaitons = _pendingOperaitons;

#pragma mark lazy instantiation

-(NSMutableArray *)photos{
    if(!_photos){
        NSURL *dataSourceURL = [NSURL URLWithString:kDatasourceURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:dataSourceURL];
        
        AFHTTPRequestOperation *datasource_download_operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        [datasource_download_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSData *datasouce_data = (NSData *)responseObject;
            NSString *datasouce_data = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [datasouce_data dataUsingEncoding:NSUTF8StringEncoding];
            //CFPropertyListRef *plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)datasouce_data, kCFPropertyListImmutable, NULL);
            
            //if(plist == nil) return nil;
            //if ([(id)plist isKindOfClass:[NSDictionary class]]) {
               // return [(NSDictionary *)plist autorelease];
            //}
            ///else {
               // CFRelease(plist);
               // return nil;
            //}
            NSDictionary *datasource_dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            //NSDictionary *datasource_dictionary = (__bridge NSDictionary *)plist;
            
            NSMutableArray *records = [NSMutableArray array];
            
            for (NSString *key in datasource_dictionary) {
                PhotoRecord *record = [[PhotoRecord alloc] init];
                record.URL = [NSURL URLWithString: [datasource_dictionary objectForKey:key]];
                record.name = key;
                [records addObject:record];
                record = nil;
            }
            
            self.photos =records;
            
            //CFRelease(data);
            
            [self.tableView reloadData];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //Connection error message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            [[UIApplication sharedApplication ] setNetworkActivityIndicatorVisible:NO];
        }];
        
        [self.pendingOperaitons.downloadQueue addOperation:datasource_download_operation];
        //_photos = [[NSMutableArray alloc] initWithContentsOfURL:dataSourceURL];
    }
    return _photos;
}

-(PendingOperations *)pendingOperaitons{
    if (!_pendingOperaitons) {
        _pendingOperaitons = [[PendingOperations alloc] init];
    }
    return _pendingOperaitons;
}

- (void)viewDidLoad {
    self.title = @"Classic Photos";
    self.tableView.rowHeight = 80.0;
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [self cancelAllOperations];
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger count = self.photos.count;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* kCellIdentifier =@"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = activityIndicatorView;
    }
    
    PhotoRecord *aRecord = [self.photos objectAtIndex:indexPath.row];
    
    if(aRecord.hasImage){
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = aRecord.image;
        cell.textLabel.text = aRecord.name;
    }
    else if(aRecord.isFailed){
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Failed.png"];
        cell.textLabel.text = @"Failed to load";
    }
    else{
        [((UIActivityIndicatorView *)cell.accessoryView) startAnimating];
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.textLabel.text = @"";
        if(!tableView.dragging && !tableView.decelerating){
           [self startOperationsForPhotoRecord:aRecord atIndexPath:indexPath];
        }
    }

    return cell;
}


-(void)startOperationsForPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath{
    if(!record.hasImage){
        [self startImageDownloadingForPhotoRecord:record atIndexPath:indexPath];
    }
    
    if(!record.isFiltered){
        [self startImageFiltrationForPhotoRecord:record atIndexPath:indexPath];
    }
}


-(void)startImageDownloadingForPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath{
   
    if(![self.pendingOperaitons.downloadsInProgress.allKeys containsObject:indexPath]){
       //start downloading
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        [self.pendingOperaitons.downloadsInProgress setObject:imageDownloader forKey:indexPath];
        [self.pendingOperaitons.downloadQueue addOperation:imageDownloader];
    }
}


-(void)startImageFiltrationForPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath{
    if(![self.pendingOperaitons.filtrationsProgress.allKeys containsObject:indexPath]){
        //start filtration
        ImageFiltration *imageFiltration = [[ImageFiltration alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        
        ImageDownloader *dependency = [self.pendingOperaitons.downloadsInProgress objectForKey:indexPath];
        if(dependency)
            [imageFiltration addDependency:dependency];
        
        [self.pendingOperaitons.filtrationsProgress setObject:imageFiltration forKey:indexPath];
        [self.pendingOperaitons.filtrationQueue addOperation:imageFiltration];
    }
}



-(void)imageDownloaderDidFinish:(ImageDownloader *)downloader{
    
    NSIndexPath *indexPath = downloader.indexPathInTableView;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.pendingOperaitons.downloadsInProgress removeObjectForKey:indexPath];
}


-(void)imageFiltrationDidFinish:(ImageFiltration *)filtration{
    
    NSIndexPath *indexPath = filtration.indexPathInTableView;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.pendingOperaitons.filtrationsProgress removeObjectForKey:indexPath];
}
#pragma mark - Image filtration

//-(UIImage *)applySepiaFilterToImage:(UIImage*)image{
//    CIImage *inputImage =[CIImage imageWithData:UIImagePNGRepresentation(image)];
//    UIImage *sepiaImage =nil;
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
//    CIImage *outputImage = [filter outputImage];
//    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
//    CGImageRelease(outputImageRef);
//    return sepiaImage;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

#pragma mark -
#pragma mark - UIScrollView delegate


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  
      //[self su]
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{


}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

}



#pragma mark - Cancelling , suspending, resuming queues / operations

-(void)suspendAllOperations{
   
    [self.pendingOperaitons.downloadQueue setSuspended:YES];
    [self.pendingOperaitons.filtrationQueue setSuspended:YES];
}


-(void)resumeAllOperations{
    [self.pendingOperaitons.downloadQueue setSuspended:NO];
    [self.pendingOperaitons.filtrationQueue setSuspended:NO];
}

-(void)cancelAllOperations{
    [self.pendingOperaitons.downloadQueue cancelAllOperations];
    [self.pendingOperaitons.filtrationQueue cancelAllOperations];
}


-(void)loadImagesForOnscreenCells{
    NSSet *visibleRows = [NSSet setWithArray:[self.tableView indexPathsForVisibleRows]];
    
    NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperaitons.downloadsInProgress allKeys]];
    [pendingOperations addObjectsFromArray:[self.pendingOperaitons.filtrationsProgress allKeys
                                            ]];
    
    NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
    NSMutableSet *toBeStarted = [visibleRows mutableCopy];
    
    [toBeStarted minusSet:pendingOperations];
    
    [toBeCancelled minusSet:visibleRows];
    
    for (NSIndexPath *anIndexPath in toBeCancelled) {
        ImageDownloader *pendngDownload = [self.pendingOperaitons.downloadsInProgress objectForKey:anIndexPath];
        [pendngDownload cancel];
        [self.pendingOperaitons.downloadsInProgress removeObjectForKey:anIndexPath];
        
        ImageFiltration *pendingFiltration = [self.pendingOperaitons.filtrationsProgress objectForKey:anIndexPath];
        [pendingFiltration cancel];
        [self.pendingOperaitons.filtrationsProgress removeObjectForKey:anIndexPath];
    }
    toBeCancelled = nil;
    
    for (NSIndexPath * anIndexPath in toBeStarted) {
        PhotoRecord *recordToProcess = [self.photos objectAtIndex:anIndexPath.row];
        [self startOperationsForPhotoRecord:recordToProcess atIndexPath:anIndexPath];
    }
    toBeStarted = nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
