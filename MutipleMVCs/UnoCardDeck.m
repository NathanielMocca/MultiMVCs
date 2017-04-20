//
//  UnoCardDeck.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "UnoCardDeck.h"
#import "UnoCard.h"

@implementation UnoCardDeck

-(instancetype)init{
    self = [super init];
    if(self){
        for (NSString *suit in [UnoCard validSuits]){
            for(NSUInteger rank =1; rank <= [UnoCard maxRank];rank ++){
                UnoCard *card = [[UnoCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
