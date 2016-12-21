//
//  PokemonCell.h
//  pokedex
//
//  Created by NEXTAcademy on 10/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UIButton *pokemonType;


@end
