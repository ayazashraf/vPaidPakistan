//
//  MenuAndDetailVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 15/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "MenuAndDetailVC.h"
#import "MainHomeTableViewCell.h"
#import "PastOrderCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "MyAnnotation.h"
#import "JPSThumbnailAnnotation.h"
#import "imageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commentTableViewCell.h"
#import "AllCommentsVC.h"
#import "MapDirectionVC.h"
#import "Constants.h"
#import "OrderSummaryVC.h"
#import "iToast.h"
#import "placesVideoCell.h"
#import "TrackOrderDetailVC.h"
#import "CategoryImageCell.h"

@interface MenuAndDetailVC ()
{
    BOOL b;
    NSArray * cat_images;
}
@property (strong, nonatomic) IBOutlet UIWebView *videoCoverWebView;
@property NSMutableArray* tablewViewArray;
@property NSArray* thumbnails;
@property NSMutableArray* address1;
@property NSMutableArray* item_details;
@property UITapGestureRecognizer *singleFingerTap;
@property (strong, nonatomic) NSDictionary * googleApiData;
@end

@implementation MenuAndDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self RequestForProductsWithPlaceId:[self.placesDetails valueForKey:@"place_id"]];
    
    cat_images=@[@"all categories.png",@"food & drink.png",@"travel & transportation.png",@"sports & recreation.png",@"shopping.png",@"arts & entertainment.png",@"automotive.png",@"personal care.png",@"cloths & accessories.png",@"computer & electronics.png",@"business & professional service.png",@"health & medicine.png",@"home & garden.png",@"real estate.png",@"community &  government.png",@"education.png",@"legal & financial.png",@"media & communication.png",@"construction & contraction.png",@"industry & agriculture.png"];
    self.videoCoverWebView.delegate = self;
    self.videoCoverWebView.hidden = NO;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.videoCoverWebView.scrollView.contentOffset = CGPointMake(self.view.frame.size.width/2, self.videoCoverWebView.frame.size.height/2);
    //https://player.vimeo.com/video/134588611
    NSURL * url = [NSURL URLWithString:@"https://www.youtube.com/embed/OmNSHVXEPE0"];
    [self.videoCoverWebView loadRequest:[NSURLRequest requestWithURL:url]];
    NSString * str_vimeo = [NSString stringWithFormat:@"<iframe src=\"https://player.vimeo.com/video/134588611\" width=\"%f\" height=\"%f\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>", self.view.frame.size.width, self.videoCoverWebView.frame.size.height];
    //<p><a href=\"https://vimeo.com/134588611\">KFC</a> from <a href=\"https://vimeo.com/resncreative\">Resn</a> on <a href=\"https://vimeo.com\">Vimeo</a>.</p>
    [self.videoCoverWebView loadHTMLString:str_vimeo baseURL:nil];
    
    [self.resturant_cover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGES_BASE_URL_VPAID, [self.placesDetails valueForKey:@"business_cover"]]] placeholderImage:nil];
    self.resturantMapView.delegate = self;
    [self StyleMyBtn:self.menuBtn];
    [self StyleMyBtn:self.pastOrderBtn];
    [self StyleMyBtn:self.informationBtn];
    
    [self StyleMyBtn:self.websiteBtn];
    [self StyleMyBtn:self.callBtn];
    [self StyleMyBtn:self.directionsBtn];
    _mainScrollView.scrollEnabled = NO;
    self.menuSearchBar.delegate = self;
    
    self.singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleFingerTap];
    self.singleFingerTap.enabled = NO;
    
    b = NO;
    
    self.thumbnails = [NSArray arrayWithObjects:@"kfcLogo1.png", @"burgerKing.png",@"ginsoy.png",@"hardees.jpg",@"kababjee.jpg",@"kababjee.jpg",  nil];
    
    [self initData];
    self.tablewViewArray = [[NSMutableArray alloc] init];
    [self.tablewViewArray addObject:@"KFC"];
    [self.tablewViewArray addObject:@"Burger King"];
    [self.tablewViewArray addObject:@"Ginsoy"];
    [self.tablewViewArray addObject:@"Hardees"];
    [self.tablewViewArray addObject:@"Kababjee's"];
    self.address1 = [[NSMutableArray alloc]init];
    [self.address1  addObject:@"4th Floor, Park Towers,، Shahrah-e-Firdousi, Karachi 75500"];
    
    [self.address1  addObject:@"Dolmen Mall,، Tariq Road، Karachi"];
    [self.address1  addObject:@" 29C Khyban-e-Shahbaz, Phase VI, Karachi"];
    [self.address1  addObject:@"Shahra-e-Sher Shah Suri, Karachi"];
    [self.address1  addObject:@"Allama Iqbal Rd, Karachi"];
    [self.menuTableView reloadData];
    //    NSString *htmlString = @"<font size=\"5\"><p>4th Floor, Park Towers,، Shahrah-e-Firdousi, Karachi 75500<br><br><font color=\"green\">Open today · 12PM–12AM</font><br><br><b>Description:</b> Fast-food chain known for its buckets of fried chicken, plus wings & sides.</p></font>";
    
    //NSString *htmlString = @"<font size=\"5\"><p>4th Floor, Park Towers,، Shahrah-e-Firdousi, Karachi 75500<br><br><b>Hours: </b><font color=#747489>Open today</font> <font color=\"green\">12PM–12AM</font><br><br><b>Description:</b> Fast-food chain known for its buckets of fried chicken, plus wings & sides.</p></font>";
    
    //    float sizeOfContent = 0;
    //    UIView *lLast = [self.mainScrollView.subviews lastObject];
    //    NSInteger wd = lLast.frame.origin.y;
    //    NSInteger ht = lLast.frame.size.height;
    //
    //    sizeOfContent = wd+ht + 400;
    //
    //    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width, sizeOfContent);
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self.resturantInsideImageCollectionView registerNib:[UINib nibWithNibName:@"placesVideoCell" bundle:nil] forCellWithReuseIdentifier:@"placesVideoCell"];
    
    [self MenuTableDynamicPlacement];
    self.tableViewHeaderView = [self.view viewWithTag:1001];
    self.menuTableView.tableHeaderView = [self.view viewWithTag:1001];
}
-(void)MenuTableDynamicPlacement
{
    NSLog(@"view height: %f scroll height: %f", self.view.frame.size.height, self.mainScrollView.frame.size.height);
    UIView * btnView = [self.view viewWithTag:101];
    
    CGRect menuRect = CGRectMake(0, btnView.frame.origin.y+btnView.frame.size.height+8, self.view.frame.size.width, self.view.frame.size.height - (btnView.frame.origin.y+btnView.frame.size.height + 8+64)); // 8 for spacing, 64 for naivgation bar
    NSLog(@"khatam: %f", menuRect.size.height);
    [self.menuTableView setFrame:menuRect];
    
    CGRect categoryCollectionRect = CGRectMake(0, 0, self.view.frame.size.width, 52);
    [self.categoryCollectionView setFrame:categoryCollectionRect];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.topItem.title = self.title_of_resturant;
}

-(void)initData
{
    _item_details = [[NSMutableArray alloc] init];
    // for(int i = 0; i < 2; i++)
    // {
    NSMutableDictionary * dicTemp1 = [[NSMutableDictionary alloc] init];
    [dicTemp1 setValue:@"Brekkie Crunch Wrap" forKey:@"item_name"];
    [dicTemp1 setValue:@"Beef cooked in a pastry crunch" forKey:@"item_detail"];
    [dicTemp1 setValue:@"240" forKey:@"item_price"];
    [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
    [dicTemp1 setValue:@"01" forKey:@"item_id"];
    
    [_item_details addObject:dicTemp1];
    
    NSMutableDictionary * dicTemp2 = [[NSMutableDictionary alloc] init];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_name"];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_detail"];
    [dicTemp2 setValue:@"150" forKey:@"item_price"];
    [dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
    [dicTemp2 setValue:@"02" forKey:@"item_id"];
    [_item_details addObject:dicTemp2];
    
    NSMutableDictionary * dicTemp3 = [[NSMutableDictionary alloc] init];
    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos" forKey:@"item_name"];
    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
    [dicTemp3 setValue:@"150" forKey:@"item_price"];
    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
    [dicTemp3 setValue:@"03" forKey:@"item_id"];
    [_item_details addObject:dicTemp3];
    
    dicTemp1 = [[NSMutableDictionary alloc] init];
    [dicTemp1 setValue:@"Brekkie Crunch Wrap 2" forKey:@"item_name"];
    [dicTemp1 setValue:@"Beef cooked in a pastry crunch" forKey:@"item_detail"];
    [dicTemp1 setValue:@"240" forKey:@"item_price"];
    [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
    [dicTemp1 setValue:@"04" forKey:@"item_id"];
    
    [_item_details addObject:dicTemp1];
    
    dicTemp2 = [[NSMutableDictionary alloc] init];
    [dicTemp2 setValue:@"Chilli Twist 2" forKey:@"item_name"];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_detail"];
    [dicTemp2 setValue:@"150" forKey:@"item_price"];
    [dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
    [dicTemp2 setValue:@"05" forKey:@"item_id"];
    [_item_details addObject:dicTemp2];
    
    dicTemp3 = [[NSMutableDictionary alloc] init];
    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos 2" forKey:@"item_name"];
    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
    [dicTemp3 setValue:@"150" forKey:@"item_price"];
    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
    [dicTemp3 setValue:@"06" forKey:@"item_id"];
    [_item_details addObject:dicTemp3];
}
-(void)RequestForProductsWithPlaceId:(NSString *)place_id
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //http://localhost/ci_vpaid/index.php/ProductController/Products?place_id=1
    NSString *string = [NSString stringWithFormat:@"%@%@?place_id=%@", BASE_URL_VPAID_POST, GET_PRODUCTS, place_id];
    NSURL *url = [NSURL URLWithString:string];
    NSLog(@"MenuAndDetailVC: %@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            NSString *checkError = [data valueForKey:@"error"];
            if([checkError integerValue] == 0)
            {
                // NSDictionary *responseData = [data valueForKey:@"results"];
                if([[data valueForKey:@"status"] isEqualToString:@"OK"])
                {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    _item_details = [[NSMutableArray alloc] initWithArray:[data valueForKey:@"products"]];
                    [self.menuTableView reloadData];
                }
            }
            else{
                [[[iToast makeText:@"internal server error..."] setDuration:iToastDurationNormal] show];
            }
            
        }else if ([responseObject isKindOfClass:[NSArray class]]){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[iToast makeText:@"I m in Array"] setDuration:iToastDurationNormal] show];
            
        }
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"Error: %@", error);
             [[[iToast makeText:@"No internet connection! Try again later."] setDuration:iToastDurationNormal] show];
         }];
}
-(UIButton*)StyleMyBtn:(UIButton*)btn
{
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    return btn;
}

#pragma mark - UITABLEVIEW DATASOURVE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _commentsTableView)
        return 4;
    if(b)
        return self.tablewViewArray.count;
    else
        return self.item_details.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _commentsTableView)
    {
        static NSString *CellID = @"commentTableViewCell";
        commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"commentTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            //6EF0DC
        }
        cell.commentName.text = [[[self.googleApiData valueForKey:@"reviews"] objectAtIndex:indexPath.row] valueForKey:@"author_name"];
        cell.commentDescription.text = [[[self.googleApiData valueForKey:@"reviews"] objectAtIndex:indexPath.row] valueForKey:@"text"];
        //
        cell.commentImgBtn.tag = indexPath.row;
        [cell.commentImgBtn addTarget:self action:@selector(commentImgBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.commentImg sd_setImageWithURL:[NSURL URLWithString:[[[self.googleApiData valueForKey:@"reviews"] objectAtIndex:indexPath.row] valueForKey:@"profile_photo_url"]] placeholderImage:nil];
        return cell;
    }
    if(b)
    {
        static NSString *CellID = @"PastOrderCell";
        PastOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastOrderCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            //6EF0DC
        }
        cell.ResturantName.text = @"KFC";//[self.tablewViewArray objectAtIndex:indexPath.row];
        cell.ResturantAddress.text = [self.address1 objectAtIndex:indexPath.row];
        cell.ResturantLogo.image = [UIImage imageNamed:[self.thumbnails objectAtIndex:indexPath.row]];
        return cell;
    }
    else
    {
        //static NSString *simpleTableIdentifier = @"MainHomeTableViewCell";
        
        MainHomeTableViewCell *cell = (MainHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MainHomeTableViewCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainHomeTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.ResturantName.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_name"];
        cell.ResturantAddress.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_detail"];
        cell.ResturantLogo.image = [UIImage imageNamed:[[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_image"]];
        cell.addToCartBtn.tag=indexPath.row;
        [cell.addToCartBtn addTarget:self action:@selector(addToCartBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.imageBtn.tag=indexPath.row;
        [cell.imageBtn addTarget:self action:@selector(ImageLargerBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.amountLabel.text =[NSString stringWithFormat:@"$ %@", [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_price"]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _commentsTableView)
    {
        return 77;
    }
    if(b)
        return 119;
    else
        return 88;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //menuDetailLargerVC
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == _commentsTableView)
    {
        self.commentLargerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentLargerVC"];
        self.commentLargerVC.view.frame = self.view.frame;
        [self.commentLargerVC.closeBtn addTarget:self action:@selector(closeCommentLarger) forControlEvents:UIControlEventTouchUpInside];
        self.commentLargerVC.author_dict =[[self.googleApiData valueForKey:@"reviews"] objectAtIndex:indexPath.row];
        [self.commentLargerVC.author_img sd_setImageWithURL:[NSURL URLWithString: [self.commentLargerVC.author_dict valueForKey:@"profile_photo_url"]] placeholderImage:nil];
        [self.commentLargerVC setScreen];
        UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:self.commentLargerVC.view];
    }
    else
    {
        if(b)
        {
            TrackOrderDetailVC * todVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TrackOrderDetailVC"];
            
            [self.navigationController pushViewController:todVC animated:YES];
        }
        else
        {
            self.menuDetailLargerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuDetailLargerVC"];
            self.menuDetailLargerVC.view.frame = self.view.frame;
            [self.menuDetailLargerVC.closeBtn addTarget:self action:@selector(closeMenuLarger) forControlEvents:UIControlEventTouchUpInside];
            
            self.menuDetailLargerVC.fg_name.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_name"];
            self.menuDetailLargerVC.fg_description.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_detail"];
            self.menuDetailLargerVC.fg_image.image = [UIImage imageNamed:[[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_image"]];
            self.menuDetailLargerVC.fg_price.text = [NSString stringWithFormat:@"Rs %@", [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_price"]];
            self.menuDetailLargerVC.item_dic = [[NSDictionary alloc] initWithDictionary:[self.item_details objectAtIndex:indexPath.row]];
            [self.menuDetailLargerVC setScreen];
            UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
            [currentWindow addSubview:self.menuDetailLargerVC.view];
        }
    }
}

#pragma mark - UIBUTTON's IBACTION
-(void)commentImgBtnPress:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    NSInteger btnTag = btn.tag;
    //  NSLog(@"btnTag = %d", btnTag);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[[self.googleApiData valueForKey:@"reviews"] objectAtIndex:btnTag] valueForKey:@"author_url"]]];
}
- (IBAction)cartBtnPress:(id)sender {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Current_item_cart"];
    NSArray * order_summary = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if(order_summary.count > 0)
    {
        OrderSummaryVC * osVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderSummaryVC"];
        [self.navigationController pushViewController:osVC animated:YES];
    }
    else
        [[[iToast makeText:@"Your cart is empty. Please add items in your cart."] setDuration:iToastDurationNormal] show];
}
- (IBAction)directionBtnPress:(id)sender {
    MapDirectionVC* mdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapDirectionVC"];
    mdVC.lat =  [[[[self.googleApiData valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] doubleValue];
    mdVC.lng = [[[[self.googleApiData valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] doubleValue];
    
    [self presentViewController:mdVC animated:YES completion:nil];
}
- (IBAction)seeMoreComments:(id)sender {
    AllCommentsVC * acVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AllCommentsVC"];
    acVC.commentsArray = [self.googleApiData valueForKey:@"reviews"];
    [self presentViewController:acVC animated:YES completion:nil];
}
- (IBAction)websiteBtnPress:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.googleApiData valueForKey:@"website"]]];
}
- (IBAction)callBtnPress:(id)sender {
    
    NSString *phNo = [self.googleApiData valueForKey:@"international_phone_number"];
    phNo = [phNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        
    }
}

- (IBAction)infoBtnPress:(id)sender {
    
    _mainScrollView.scrollEnabled = YES;
    if(!self.googleApiData)
    {
        [self makeRequestForGoogleApi];
        [UIView animateWithDuration:0.8 animations:^() {
            //self.resturantInfoView.hidden = NO;
            self.menuTableView.hidden = YES;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.8 animations:^() {
            self.resturantInfoView.hidden = NO;
            self.menuTableView.hidden = YES;
        }];
    }
}
- (IBAction)menuBtnPress:(id)sender {
    _mainScrollView.scrollEnabled = NO;
    [self.mainScrollView setContentOffset:
     CGPointMake(0, -self.mainScrollView.contentInset.top) animated:YES];
    [UIView animateWithDuration:8.0 animations:^() {
        
        self.resturantInfoView.hidden = YES;
        self.menuTableView.hidden = NO;
        self.menuTableView.tableHeaderView = self.tableViewHeaderView;
        b = NO;
        // [_menuTableView beginUpdates];
        [_menuTableView reloadData];
        // [_menuTableView endUpdates];
    }];
}
- (IBAction)pastOrderPress:(id)sender {
    _mainScrollView.scrollEnabled = NO;
    [self.mainScrollView setContentOffset:
     CGPointMake(0, -self.mainScrollView.contentInset.top) animated:YES];
    [UIView animateWithDuration:8.0 animations:^() {
        
        self.resturantInfoView.hidden = YES;
        self.menuTableView.hidden = NO;
        //[self.menuTableView viewWithTag:1001].hidden = YES;
        self.menuTableView.tableHeaderView = nil;
        b = YES;
        // [_menuTableView beginUpdates];
        [_menuTableView reloadData];
        //  [_menuTableView endUpdates];
    }];
}
-(void)ImageLargerBtnPress:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger buttonTagIndex = btn.tag;
    
    _imageLargerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageLargerVC"];
    _imageLargerVC.view.frame = self.view.frame;
    _imageLargerVC.showImage.image =[UIImage imageNamed:[[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_image"]];
    
    [_imageLargerVC.closeBtn addTarget:self action:@selector(closeBuyNow) forControlEvents:UIControlEventTouchUpInside];
    
    [_imageLargerVC setScreen];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_imageLargerVC.view];
}
-(void)addToCartBtn:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger buttonTagIndex = btn.tag;
    NSString * str = [[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_name"];
    NSLog(@"str = %@", str);
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"item_id == %@", [[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_id"]];
    [request setEntity:[NSEntityDescription entityForName:@"Current_item_cart" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(results.count > 0)
    {
        NSManagedObject *order_items = [results firstObject];
        int num_of_item = [[order_items valueForKey:@"item_quantity"] intValue];
        num_of_item++;
        double price =[[order_items valueForKey:@"item_price"] doubleValue];
        price = num_of_item * price;
        [order_items setValue:[NSString stringWithFormat:@"%d", num_of_item] forKey:@"item_quantity"];
        [order_items setValue:[NSString stringWithFormat:@"%f", price] forKey:@"item_price_total"];
        
        [[[iToast makeText:[NSString stringWithFormat:@"%@ has added into your cart.",str]] setDuration:iToastDurationNormal] show];
    }
    else
    {
        //Create a new managed object
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Current_item_cart" inManagedObjectContext:context];
        [newDevice setValue:[[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_name"] forKey:@"item_name"];
        [newDevice setValue:[[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_price"] forKey:@"item_price"];
        [newDevice setValue:[[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_price"] forKey:@"item_price_total"];
        [newDevice setValue:[[self.item_details objectAtIndex:buttonTagIndex] valueForKey:@"item_id"] forKey:@"item_id"];
        [newDevice setValue:@"1" forKey:@"item_quantity"];
        
        
        /*NSError */error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            [[[iToast makeText:[NSString stringWithFormat:@"%@ has added into your cart.",str]] setDuration:iToastDurationNormal] show];
        }
    }
}

-(void)CartBtnPress:(id)sender
{
    
}
#pragma mark - CORE DATA METHODS
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
#pragma mark - UISEARCHBAR DELEGATE
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.singleFingerTap.enabled = YES;
}
//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    self.singleFingerTap.enabled = NO;
    [self.menuSearchBar resignFirstResponder];
    [self.menuSearchBar setText:@""];
}
- (void) makeRequestForGoogleApi
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //ChIJD8_wmcA9sz4RJ3JMHWyZnGo burger king
    //ChIJ1d5TsJ4-sz4RPzjQUU3DS2M kfc
    //ChIJxyguYiI5sz4Rk-DUfTIQn-0 mcdonald
    NSString * place_id = @"ChIJ1d5TsJ4-sz4RPzjQUU3DS2M"; // mcdonald
    //https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJ1d5TsJ4-sz4RPzjQUU3DS2M&key=AIzaSyB5f-NTLOuPywGCAVIIcc-dgrBLTk6-o80
    NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place_id, GOOGLE_API_KEY];
    
    NSURL *url = [NSURL URLWithString:string];
    NSLog(@"MenuAndDetailVC: %@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            NSString *checkError = [data valueForKey:@"error"];
            if([checkError integerValue] == 0){
                // NSDictionary *responseData = [data valueForKey:@"results"];
                if([[data valueForKey:@"status"] isEqualToString:@"OK"])
                {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.googleApiData = [data valueForKey:@"result"];
                    [self ParseGoogleData];
                }
                
            }
            else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"internal server error..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            
        }else if ([responseObject isKindOfClass:[NSArray class]]){
            //This is an NSArray, you cannot call 'valueForKey' on this responseObject
        }
        
        
        
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"Error: %@", error);
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"no internet connection.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }];
    
}
-(void)ParseGoogleData
{
    self.ratingStarsView.canEdit = NO;
    self.ratingStarsView.maxRating = 5;
    if(![[self.googleApiData valueForKey:@"formatted_phone_number"] isEqualToString:@""])
        self.phNumLabel.text =[self.googleApiData valueForKey:@"formatted_phone_number"];
    else
        self.phNumLabel.text = @"Phone Number isn't available";
    
    self.ratingStarsView.rating = [[self.googleApiData valueForKey:@"rating"] doubleValue];
    // self.ratingLabel.text =[self.googleApiData valueForKey:@"rating"];
    if(![[self.googleApiData valueForKey:@"formatted_address"] isEqualToString:@""])
        self.addressLabel.text = [self.googleApiData valueForKey:@"formatted_address"];
    else
        self.addressLabel.text = @"Address isn't available";
    if([[self.googleApiData valueForKey:@"opening_hours"] valueForKey:@"open_now"])
    {
        if([[[self.googleApiData valueForKey:@"opening_hours"] valueForKey:@"open_now"] boolValue])
        {
            self.openCloseStatusLabel.text = @"Open Now!";
            self.openCloseStatusLabel.textColor = [self colorWithHexString:@"008000"];
        }
        else
        {
            self.openCloseStatusLabel.text = @"Close Now!";
            self.openCloseStatusLabel.textColor = [UIColor darkGrayColor];
        }
    }
    else
    {
        self.openCloseStatusLabel.text = @"Not Available";
        self.openCloseStatusLabel.textColor = [UIColor darkGrayColor];
    }
    //dispatch_async(dispatch_get_main_queue(), ^{
    // code here
    [_resturantMapView addAnnotations:[self annotations]];
    //});
    if([[self.googleApiData valueForKey:@"opening_hours"] valueForKey:@"weekday_text"])
    {
        NSArray * weekDays = [[NSArray alloc] initWithArray:[[self.googleApiData valueForKey:@"opening_hours"] valueForKey:@"weekday_text"]];
        
        NSString *htmlString = @"<center><font size=\"5\"><p>Monday: Closed<br>Tuesday: 12:00 PM – 12:00 AM<br>Wednesday: 12:00 PM – 12:00 AM<br>Thursday: 12:00 PM – 12:00 AM<br>Friday: 12:00 PM – 12:00 AM<br>Saturday: 12:00 PM – 12:00 AM<br>Sunday: 12:00 PM – 12:00 AM</p></font></center>";
        [NSString stringWithFormat:@"<center><font size=\"5\"><p>%@<br>%@<br>%@<br>%@<br>%@<br>%@<br>%@</p></font></center>",[weekDays objectAtIndex:0],[weekDays objectAtIndex:1],[weekDays objectAtIndex:2],[weekDays objectAtIndex:3],[weekDays objectAtIndex:4],[weekDays objectAtIndex:5],[weekDays objectAtIndex:6]];
        
        NSData *htmlStringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *attributedStringOptions = @{
                                                  NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                                                  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
                                                  };
        // assign to texfield 2
        self.resturantDetails.attributedText = [[NSAttributedString alloc] initWithData:htmlStringData
                                                                                options: attributedStringOptions
                                                                     documentAttributes:nil error:nil];
    }
    else
    {
        self.resturantDetails.text = @"Weekly Schedule isn't available";
        self.resturantDetails.textAlignment = NSTextAlignmentCenter;
        self.resturantDetails.textColor = [UIColor darkGrayColor];
    }
    if([self.googleApiData valueForKey:@"photos"])
        [self.resturantInsideImageCollectionView reloadData];
    if([self.googleApiData valueForKey:@"reviews"])
        [self.commentsTableView reloadData];
    
    self.resturantInfoView.hidden = NO;
}
- (NSArray *)annotations {
    JPSThumbnail *resturantAnnotation = [[JPSThumbnail alloc] init];
    resturantAnnotation.image = self.resuturantImage;//[UIImage imageNamed:@"kfcLogo1"];
    resturantAnnotation.title = @"KFC";
    resturantAnnotation.subtitle = @"";
    resturantAnnotation.coordinate = CLLocationCoordinate2DMake([[[[self.googleApiData valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] doubleValue], [[[[self.googleApiData valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] doubleValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(resturantAnnotation.coordinate, 2500, 4000);
    [_resturantMapView setRegion:[_resturantMapView regionThatFits:region] animated:YES];
    resturantAnnotation.disclosureBlock = ^{};
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:resturantAnnotation],
             ];
}

-(MyAnnotation *)focusmapWithLat:(double)lat Long:(double)log
{
    MyAnnotation *annot=[MyAnnotation alloc];
    CLLocationCoordinate2D cordloc;
    cordloc.latitude=lat ;
    cordloc.longitude=log;
    [annot setCoordinate:cordloc];
    annot.title = @"location 1";//BusinessTitle;
    [_resturantMapView addAnnotation:annot];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 1.0;
    span.longitudeDelta = 1.0;
    
    region.span = span;
    region.center = cordloc;
    [_resturantMapView setRegion:region animated:YES];
    
    return annot;
}
#pragma mark - UICOLLECTIONVIEW DATASOURCE
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == self.categoryCollectionView)
    {
        return cat_images.count;
    }
    else
    {
        NSArray * temp = [[NSArray alloc] initWithArray:[self.googleApiData valueForKey:@"photos"]];
        return temp.count + 2;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.categoryCollectionView)
    {
        CategoryImageCell * cell = (CategoryImageCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryImageCell" forIndexPath:indexPath];
        cell.cat_img.image = [UIImage imageNamed:[cat_images objectAtIndex:indexPath.row]];
        return cell; 
    }
    else
    {
        NSArray * temp = [[NSArray alloc] initWithArray:[self.googleApiData valueForKey:@"photos"]];
        if(indexPath.row > temp.count-1)
        {
            static NSString *identifier = @"placesVideoCell";
            placesVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.videoThumbnailWebView.delegate = self;
            // NSURL * url = [NSURL URLWithString:@"https://www.youtube.com/embed/OmNSHVXEPE0"];
            // [cell.videoThumbnailWebView loadRequest:[NSURLRequest requestWithURL:url]];
            NSString * str_vimeo = [NSString stringWithFormat:@"<iframe src=\"https://player.vimeo.com/video/134588611\" width=\"%f\" height=\"%f\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>", cell.frame.size.width, cell.frame.size.height];
            
            [cell.videoThumbnailWebView loadHTMLString:str_vimeo baseURL:nil];
            return cell;
            
        }
        else
        {
            static NSString *identifier = @"imageCell";
            imageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=105&maxheight=82&photoreference=%@&key=%@&sensor=false", [[[self.googleApiData valueForKey:@"photos"] objectAtIndex:indexPath.row] valueForKey:@"photo_reference"], GOOGLE_API_KEY];
            NSURL * url = [NSURL URLWithString:str];
            [cell.images sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder_105_82"]];
            return cell;
        }
    }
}
#pragma mark - UICOLLECTIONVIEW DELEGATE

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.categoryCollectionView)
    {
        
    }
    else
    {
        _imageLargerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageLargerVC"];
        _imageLargerVC.view.frame = self.view.frame;
        NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=576&maxheight=432&photoreference=%@&key=%@&sensor=false", [[[self.googleApiData valueForKey:@"photos"] objectAtIndex:indexPath.row] valueForKey:@"photo_reference"], GOOGLE_API_KEY];
        _imageLargerVC.imageUrl = [NSURL URLWithString:str];
        [_imageLargerVC.showImage sd_setImageWithURL:_imageLargerVC.imageUrl placeholderImage:[UIImage imageNamed:@"placeHolder_288_216"]];
        
        [_imageLargerVC.closeBtn addTarget:self action:@selector(closeBuyNow) forControlEvents:UIControlEventTouchUpInside];
        [_imageLargerVC setScreen];
        UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:_imageLargerVC.view];
        
    }
}
-(void)closeBuyNow
{
    
    [self.imageLargerVC.view removeFromSuperview];
}
-(void)closeCommentLarger
{
    
    [self.commentLargerVC.view removeFromSuperview];
}
//
-(void)closeMenuLarger
{
    
    [self.menuDetailLargerVC.view removeFromSuperview];
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
        //        JPSThumbnailAnnotation * temp = (JPSThumbnailAnnotation*)view;
        // NSLog(@"temp title");
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
        // NSLog(@"i = %d", i);
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
#pragma mark - UIWEBVIEW DELEGATE
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView == self.videoCoverWebView)
    {
        NSLog(@"I m in webview delegate!");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.videoCoverWebView.scrollView.contentOffset = CGPointMake(8, 10);
        self.videoCoverWebView.scrollView.scrollEnabled = NO;
    }
    else
    {
        NSLog(@"I m in webview delegate 2 !");
        webView.scrollView.contentOffset = CGPointMake(0, 10);
        webView.scrollView.scrollEnabled = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"I m in didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
