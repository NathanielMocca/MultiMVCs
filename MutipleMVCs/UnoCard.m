//
//  UnoCard.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "UnoCard.h"

@implementation UnoCard

-(int) match:(NSArray *)otherCards{
    int score = 0;
    
    if([otherCards count] == 1){
        UnoCard *otherCard = [otherCards firstObject];
        if(otherCard.contents == self.contents){
            score = 10;
        }
    }
    return score;
}

-(NSString *)contents{
    NSArray *rankStrings = [UnoCard rankStrings];
    return [self.suit stringByAppendingString:rankStrings[self.rank]];
}

@synthesize suit = _suit;

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

-(void)setSuit:(NSString *)suit{
    if([[UnoCard validSuits]containsObject:suit]){
        _suit = suit;
    }
}

+(NSArray *)rankStrings{
    return @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
}

+(NSArray *)validSuits{
    return @[@"b",@"g"];
}

-(void)setRank:(NSUInteger)rank{
    if(rank <= [UnoCard maxRank]){
        _rank = rank;
    }
}

+(NSUInteger)maxRank{
    return [[self rankStrings] count]-1;
}


@end
