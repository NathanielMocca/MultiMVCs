//
//  UnoCardMatchingGame.h
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UnoCard.h"
#import "UnoCardDeck.h"

@interface UnoCardMatchingGame : NSObject

-(instancetype)initUnoCardDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(UnoCard *)cardAtIndex:(NSUInteger)index;
-(NSMutableArray *)shuffle:(NSMutableArray*)cards;

@property (nonatomic,readonly)NSUInteger score;

@end
