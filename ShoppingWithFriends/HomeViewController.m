//
//  HomeViewController.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/20/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"Logout" sender:self];
}


@end
