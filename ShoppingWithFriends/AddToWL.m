//
//  AddToWL.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "AddToWL.h"
#import <Parse/Parse.h>

@interface AddToWL()

@property (weak, nonatomic) IBOutlet UITextField *item;
@property (weak, nonatomic) IBOutlet UITextField *price;


@end

@implementation AddToWL

- (IBAction)addToWL:(id)sender {
    PFUser *thisUser = [PFUser currentUser];
    NSMutableArray *wl = thisUser[@"WishList"];
    PFObject *newItem = [PFObject objectWithClassName:@"Item"];
    newItem[@"name"] = _item.text;
    NSNumber *thePrice = [[NSNumber alloc] initWithInteger:[_price.text integerValue]];
    newItem[@"price"] = thePrice;
    [wl addObject:newItem];
    thisUser[@"WishList"] = wl;
    [thisUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self performSegueWithIdentifier:@"Added" sender:self];
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
