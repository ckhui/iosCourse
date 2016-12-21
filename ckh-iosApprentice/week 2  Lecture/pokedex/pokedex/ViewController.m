//
//  ViewController.m
//  pokedex
//
//  Created by NEXTAcademy on 10/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"
#import "PokemonCell.h"
#import "Pokemon.h"
#import "detailedViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *pokemonTableView;
@property (strong, nonatomic) NSMutableArray *pokemons;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pokemonTableView.dataSource= self;
    self.pokemonTableView.delegate = self;
    
    //if no warning or error on autolayout constraint
    //but the cell is not displayed correctly
    //self.pokemonTableView.estimatedRowHeight = 100.0f;
    //self.pokemonTableView.rowHeight = UITableViewAutomaticDimension;
    
    //tableview
    self.pokemonTableView.tableFooterView = [UIView new];
    self.title = @"POKEDEX";
    
    self.pokemons = [[NSMutableArray alloc] init];
    //self.pokemons = [NSMutableArray array];
    
    //navigation bar
    self.navigationController.navigationBar.translucent = NO;
    [self preparePokemons];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Functions
- (void) preparePokemons{
    Pokemon *pikachu = [Pokemon new];
    pikachu.name = @"Pikachu";
    pikachu.type = @"Electric";
    pikachu.desc =@"Pika pika chuuuuu ~~~~~~";
    pikachu.picture = [UIImage imageNamed:@"pikachu"];
    pikachu.largePic = [UIImage imageNamed:@"pikachu-large"];
    
    
    Pokemon *onyx = [Pokemon new];
    onyx.name = @"onyx";
    onyx.type = @"Rock";
    onyx.desc =@"cacing";
    onyx.picture = [UIImage imageNamed:@"onyx"];
    
    Pokemon *unknown = [Pokemon new];

    [self.pokemons addObject:pikachu];
    [self.pokemons addObject:onyx];
    [self.pokemons addObject:unknown];
    
   
}

#pragma mark - UITableView Datasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%lu",self.pokemons.count);
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Pokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    
    PokemonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell"];
    
    //display pokemon name
    cell.pokemonName.text = pokemon.name;
    
    //display pokemon type and set color
    if ([pokemon.type isEqualToString:@"Fire"]){
        cell.pokemonType.backgroundColor = [UIColor redColor];
    }
    else if ([pokemon.type isEqualToString:@"Rock"]){
        cell.pokemonType.backgroundColor = [UIColor brownColor];
    }
    else if ([pokemon.type isEqualToString:@"Electric"]){
        cell.pokemonType.backgroundColor = [UIColor orangeColor];
    }
    
    [cell.pokemonType setTitle:[pokemon.type uppercaseString] forState:UIControlStateNormal];
    
    //display pokemon image
    cell.pokemonType.layer.cornerRadius = 4.0f;
    cell.pokemonType.layer.masksToBounds = YES;
    [cell.pokemonType setUserInteractionEnabled:NO];
    
    [cell.pokemonImage setImage:pokemon.picture];
    
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self  performSegueWithIdentifier:@"detailSegue" sender:self];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //first way to get selected item (pokemon)
    if ([segue.identifier isEqualToString:@"detailSegue"]){
        NSIndexPath *selectedIndexPath = [self.pokemonTableView indexPathForSelectedRow];
        Pokemon *selectedPokemon = [self.pokemons objectAtIndex:selectedIndexPath.row];
        
        detailedViewController *pokemonDetailView = [segue destinationViewController];
        pokemonDetailView.pokemon = selectedPokemon;
        
        
    }
}


@end
