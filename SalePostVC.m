//
//  SalePostVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "SalePostVC.h"
#import <Parse/Parse.h>

@interface SalePostVC()

@property (weak, nonatomic) IBOutlet UITextField *item;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *location;


@end

@implementation SalePostVC

- (IBAction)addPost:(id)sender {
    PFObject *newPost = [PFObject objectWithClassName:@"SalesReport"];
    newPost[@"name"] = _item.text;
    NSNumber *thePrice = [[NSNumber alloc] initWithInteger:[_price.text integerValue]];
    newPost[@"price"] = thePrice;
    newPost[@"location"] = _location.text;
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self performSegueWithIdentifier:@"AddPost" sender:self];
        } else {
            // There was a problem, check error.description
        }
    }];

}


- (IBAction)keyboard:(id)sender;
{
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

@end
