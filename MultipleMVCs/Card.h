//
//  Card.h
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong,nonatomic) NSString *contents;
@property(nonatomic,getter=isChosen) BOOL chosen;
@property(nonatomic,getter=isMatched) BOOL matched;

-(int) match:(NSArray *) otherCards;

@end
