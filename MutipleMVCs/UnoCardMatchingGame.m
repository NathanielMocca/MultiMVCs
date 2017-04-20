//
//  UnoCardMatchingGame.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "UnoCardMatchingGame.h"

@interface UnoCardMatchingGame()
@property (nonatomic, readwrite)NSUInteger score;
@property (nonatomic,strong)NSMutableArray *cards;
@end

@implementation UnoCardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initUnoCardDeck:(Deck *)deck{
    self = [super init];
    
    if(self){
        for(int i = 0; i < 8; i++){
            Card *card = [deck drawRandomCard];
            //避免card變成淺拷貝（ref過去,記憶體位置相同）
            Card *tempCard = [[Card alloc] init];
            tempCard.contents = card.contents;
            tempCard.chosen = card.chosen;
            tempCard.matched = card.matched;
            if(card){
                [self.cards addObject:card];
                [self.cards addObject:tempCard];
            }else{
                // if we cannot initialize properly given the arguments passed,return nil
                self = nil;
                break;
            }
        }
    }
    self.cards = [self shuffle:self.cards];
    return self;
}

-(NSMutableArray *)shuffle:(NSMutableArray *)cards{
    NSUInteger count = [cards count];
    if (count <= 1) return nil;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [cards exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return cards;
}

-(UnoCard *)cardAtIndex:(NSUInteger)index{
    //check if index is valid.
    return (index <= [self.cards count])? self.cards[index] : nil;
}

static const int MISMATCH_PANALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    //only allow unmatched cards to be chosen
    if(!card.isMatched){
        if(card.isChosen){
            //if card is chosen,then unchoose it.
            card.chosen = NO;
        }else{
            //match against other chosen card.
            
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }else{
                        self.score -= MISMATCH_PANALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}


@end
