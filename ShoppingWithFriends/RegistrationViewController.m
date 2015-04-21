//
//  RegistrationViewController.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/20/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "RegistrationViewController.h"
#import <Parse/Parse.h>

@interface RegistrationViewController()

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RegistrationViewController


-(IBAction)registration:(id)sender {
    PFUser *user = [PFUser user];
    user.username = _username.text;
    user.password = _password.text;
    user.email = _email.text;
    user[@"Name"] = _name.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"clickedRegister" sender:self];
        } else {
            // NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (IBAction)keyboard:(id)sender;
{
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

@end
