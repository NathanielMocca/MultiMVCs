//
//  GameCompleteViewController.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "GameCompleteViewController.h"

@interface GameCompleteViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ScoreGotLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;

@end

@implementation GameCompleteViewController

-(void)updateUI {
    self.ScoreGotLabel.text = self.scoreText;
    
    NSString *text = @"You flipped ";
    NSString *count = [NSString stringWithFormat:@"%i", self.flipCount];
    text = [text stringByAppendingString:count];
    text = [text stringByAppendingString:@" times."];
    self.flipCountLabel.text = text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self updateUI];
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
