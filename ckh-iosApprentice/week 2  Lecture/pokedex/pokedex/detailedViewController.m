//
//  detailedViewController.m
//  pokedex
//
//  Created by NEXTAcademy on 10/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "detailedViewController.h"

@interface detailedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageLarge;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonType;
@property (weak, nonatomic) IBOutlet UILabel *pokemonDesc;

@end

@implementation detailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.pokemon.largePic == nil){
        [self.pokemonImageLarge setImage:self.pokemon.picture];
    }
    else{
        [self.pokemonImageLarge setImage:self.pokemon.largePic];
    }
    self.pokemonName.text = [NSString stringWithFormat:@"Name : %@",self.pokemon.name];
    self.pokemonType.text = [NSString stringWithFormat:@"Type : %@",self.pokemon.type];
    self.pokemonDesc.text = [NSString stringWithFormat:@"Description : \n%@", self.pokemon.desc];
    
    self.title = self.pokemon.name;
    
    //navigation bar
    self.navigationController.navigationBar.translucent = NO;
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

@end
