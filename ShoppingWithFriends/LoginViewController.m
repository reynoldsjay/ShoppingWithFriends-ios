//
//  LoginViewController.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/20/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(IBAction)login:(id)sender {
    [PFUser logInWithUsernameInBackground:_username.text password:_password.text
        block:^(PFUser *user, NSError *error) {
        if (user) {
            NSLog(@"Logged in.");
            [self performSegueWithIdentifier:@"Login" sender:self];
            
        } else {
            // The login failed. Check error to see why.
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keyboard:(id)sender;
{
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

@end
