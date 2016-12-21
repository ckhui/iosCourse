//
//  WordViewController.m
//  Dictionary
//
//  Created by NEXTAcademy on 10/31/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *wordsArray;

@end

@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //seed your NSArray
    self.wordsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"10000_random_words" ofType:@"plist"]];
    
    //Set user default
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if(![userDefault boolForKey:@"newUser"]){
        
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        
        UITapGestureRecognizer *dismissView = [[UITapGestureRecognizer alloc]initWithTarget:imageView action:@selector(removeFromSuperview)];
        
        //[imageView addGestureRecognizer:dismissView];
        imageView.gestureRecognizers = @[dismissView];
        imageView.userInteractionEnabled = YES;
        
        imageView.image = [UIImage imageNamed:@"dictionary"];
        [self.view addSubview:imageView];
        
        [userDefault setBool:YES forKey:@"newUser"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
#pragma  mark - button
- (IBAction)onShuffleButtonPressed:(id)sender {
    [self shuffle:[self.wordsArray mutableCopy] completionHandler:^(NSArray *input){
        self.wordsArray = input;
        [self.tableView reloadData];
    }];
}

- (IBAction)onSortButtonPressed:(id)sender {
    [self sort:[self.wordsArray mutableCopy] completionHandler:^(NSArray *input){
        self.wordsArray = input;
        [self.tableView reloadData];
    }];
}

- (void) shuffle:(NSMutableArray *)array completionHandler:(void (^)(NSArray *input)) completion{
    for(NSInteger i = 0; i < array.count -1; i++){
        NSInteger randomIndex = i + arc4random() % (array.count - 1 - i);
        [array exchangeObjectAtIndex:i withObjectAtIndex:randomIndex];
    }
    completion(array);
}

- (void) sort:(NSMutableArray *)array completionHandler:(void (^)(NSArray *input))completion{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        BOOL isUnsorted = YES;
        while(isUnsorted) {
            isUnsorted = NO;
            NSUInteger count = array.count;
            NSUInteger sortProgress = 0;
            
            for (NSUInteger i =0; i <count - 1 - sortProgress; i++){
                NSString *str1 = [array objectAtIndex:i];
                NSString *str2 = [array objectAtIndex:i+1];
                if ([str1 compare:str2] > 0){
                    //NSLog(@"%@   %@   larger",str1 ,str2);
                    [array exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                    isUnsorted = YES;
                }
                sortProgress ++;
            }
        }
        completion(array);
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            completion(array);
        });
        
    });
    
}
#pragma mark - tableView datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.wordsArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.wordsArray.count;
}
@end
