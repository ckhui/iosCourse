//
//  ListViewController.m
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ListViewController.h"
#import "AppleProduct.h"
#import "DetailsViewController.h"
#import "ProductCellTableViewCell.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate>

@property (strong,nonatomic) NSMutableArray <AppleProduct *> *products;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.title = @"Apple Product";
    // Do any additional setup after loading the view.
    
    //creat apple products object
    self.products = [NSMutableArray new];
    
    AppleProduct *product1 = [[AppleProduct alloc]initWithName:@"Apple I" Date:@"1976 July 1" Url:@"https://en.wikipedia.org/wiki/Apple_I" Image:[UIImage imageNamed:@"Apple_I"]];
    
    AppleProduct *product2 = [[AppleProduct alloc]initWithName:@"iPad Pro (9.7\")" Date:@"2016 March 31" Url:@"https://en.wikipedia.org/wiki/IPad_Pro" Image:[UIImage imageNamed:@"IPad_Pro"]];
    
    AppleProduct *product3 = [[AppleProduct alloc]initWithName:@"iPhone SE" Date:@"2016 March 31" Url:@"https://en.wikipedia.org/wiki/IPhone_SE" Image:[UIImage imageNamed:@"IPhone_SE"]];
    
    AppleProduct *product4 = [[AppleProduct alloc]initWithName:@"MacBook (Early 2016)" Date:@"2016 April 19" Url:@"https://en.wikipedia.org/wiki/MacBook_(2015_version)" Image:[UIImage imageNamed:@"MacBook_with_Retina_Display"]];
    
    AppleProduct *product5 = [[AppleProduct alloc]initWithName:@"iPhone 7 Plus" Date:@"2016 September 16" Url:@"https://en.wikipedia.org/wiki/IPhone_7_Plus" Image:[UIImage imageNamed:@"IPhone_7_Plus_Jet_Black"]];
    
    AppleProduct *product6 = [[AppleProduct alloc]initWithName:@"Apple AirPods" Date:@"2016 October" Url:@"https://en.wikipedia.org/wiki/Apple_earbuds" Image:[UIImage imageNamed:@"AirPods"]];
    
    AppleProduct *product7 = [[AppleProduct alloc]initWithName:@"Apple" Date:@"Everyday" Url:@"https://en.wikipedia.org/wiki/apple" Image:[UIImage imageNamed:@"apple"]];
    
    [self.products addObject:product1];
    [self.products addObject:product2];
    [self.products addObject:product3];
    [self.products addObject:product4];
    [self.products addObject:product5];
    [self.products addObject:product6];
    [self.products addObject:product7];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    // don't forget to call [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell"];
    
    AppleProduct *displayProduct = [self.products objectAtIndex:indexPath.row];

    cell.name.text = displayProduct.name;
    cell.date.text = displayProduct.date;
    cell.image.image = displayProduct.image;

    return cell;
    
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self performSegueWithIdentifier:@"toDetailsView" sender:self];
    
}

#pragma mark - DetailViewControllerDelegate
- (void)didChangeTitleButtonClick:(DetailsViewController *)detailsViewController wtihTitle:(NSString *)newTitle{
    self.title = newTitle;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"toDetailsView"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        DetailsViewController *destinationController = [segue destinationViewController];
        destinationController.delegate = self;
        
        AppleProduct *selectedProduct = [self.products objectAtIndex:selectedIndexPath.row];
        
        
        destinationController.displayProduct = selectedProduct;
    }

}




@end
