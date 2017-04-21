//
//  AttributorSecondViewController.m
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import "AttributorSecondViewController.h"

@interface AttributorSecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulChracterLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedChracterLabel;

@end

@implementation AttributorSecondViewController


-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if(self.view.window) {
        [self updateUI];
    }
}

-(void)updateUI {
    NSAttributedString *colorfulAtrStr = [self chractersWithAttribute:NSForegroundColorAttributeName];
    self.colorfulChracterLabel.text = [NSString stringWithFormat:@"%lu colorful chracters",[colorfulAtrStr length]];
    NSAttributedString *outlinedAtrStr = [self chractersWithAttribute:NSStrokeWidthAttributeName];
    self.outlinedChracterLabel.text = [NSString stringWithFormat:@"%lu outlined chracters",[outlinedAtrStr length]];
}

-(NSAttributedString *)chractersWithAttribute:(NSString *)attributeName {
    //NSLog(@"%lu", (unsigned long)[self.textToAnalyze length]);
    NSMutableAttributedString *chracters = [[NSMutableAttributedString alloc] init];
    unsigned long index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value) {
            NSLog(@"value");
            [chracters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location +range.length;
        }else{
            index++;
        }
    }
    NSLog(@"%@", chracters);
    
    return chracters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textToAnalyze = self.passedtext;

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
