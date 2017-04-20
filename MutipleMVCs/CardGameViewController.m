//
//  CardGameViewController.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "CardGameViewController.h"
#import "GameCompleteViewController.h"
#import "UnoCardDeck.h"
#import "UnoCardMatchingGame.h"

@interface CardGameViewController ()

@property (strong,nonatomic) UnoCardMatchingGame *unoGame;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) BOOL isflipAll;
@property (weak, nonatomic) IBOutlet UIButton *flipAllButton;
@property (weak, nonatomic) IBOutlet UIButton *ResetButton;
@property (nonatomic)int flipCount;
@property (weak, nonatomic) IBOutlet UIButton *nextViewButton;
@property (nonatomic) BOOL isCompleted;

@end

@implementation CardGameViewController

-(UnoCardMatchingGame *)unoGame{
    if(!_unoGame) _unoGame = [[UnoCardMatchingGame alloc] initUnoCardDeck:[self createUnoDeck]];
    return _unoGame;
}

-(Deck *)createUnoDeck{
    return [[UnoCardDeck alloc] init];
}

- (IBAction)touchCard:(UIButton *)sender {
    [self updateUI];
    NSUInteger chooseButtonIndex =[self.cardButtons indexOfObject:sender];
    [self.unoGame chooseCardAtIndex:chooseButtonIndex];
    self.flipCount++;
    [self updateUI];
    
}

-(void)updateUI{
    //cycle through all the cardButtons and based on the corresponding card in our Model
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.unoGame cardAtIndex:cardButtonIndex];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", self.unoGame.score];
    }
    [self checkComplete];
    [self goToNext];
}

-(void)checkComplete {
    int MatchedCount = 0;
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.unoGame cardAtIndex:cardButtonIndex];
        if(card.isMatched){
            MatchedCount++;
        }
        if(MatchedCount == [self.cardButtons count]){
            self.isCompleted = YES;
        }else{
            self.isCompleted = NO;
        }
    }
}

-(void)goToNext {
    if(self.isCompleted){
    [self.nextViewButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)touchFlipAllButton:(id)sender {
    if(self.isflipAll){
        for (UIButton *cardButton in self.cardButtons){
            NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.unoGame cardAtIndex:cardButtonIndex];
            [cardButton setBackgroundImage:[self ImageContentsForFlipbackAll:card] forState:UIControlStateNormal];
        }
        self.isflipAll = NO;
    }else{
        for (UIButton *cardButton in self.cardButtons){
            NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.unoGame cardAtIndex:cardButtonIndex];
            //[cardButton setTitle:card.contents forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self ImageContents:card] forState:UIControlStateNormal];
        }
        self.isflipAll = YES;
    }
}


- (IBAction)touchResetButton:(id)sender {
    self.unoGame = nil;
    self.flipCount = 0;
    [self unoGame];
    [self updateUI];
}


-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? card.contents : @"unoback"];
}

-(UIImage *)ImageContents:(Card *)card{
    return [UIImage imageNamed:card.contents];
}

-(UIImage *)ImageContentsForFlipbackAll:(Card *)card{
    return [UIImage imageNamed:card.isMatched ? card.contents : @"unoback"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"CompleteGame"]) {
        GameCompleteViewController *vc2 = [segue destinationViewController];
        
        vc2.flipCount = self.flipCount;
        vc2.scoreText = self.scoreLabel.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
