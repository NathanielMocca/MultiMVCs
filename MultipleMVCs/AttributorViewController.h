//
//  AttributorViewController.h
//  MutipleMVCs
//
//  Created by Mocca Yang on 2017/4/20.
//  Copyright © 2017年 Mocca Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttributorViewController : UIViewController

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;

@end
