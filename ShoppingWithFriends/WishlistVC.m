//
//  WishlistVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "WishlistVC.h"
#import <Parse/Parse.h>




@implementation WishlistVC {
    
    NSMutableArray *wlitems;

}

-(void)viewDidLoad {
    
    wlitems = [PFUser currentUser][@"WishList"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wlitems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [[wlitems objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        cell.textLabel.text = object[@"name"];
    }];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[wlitems objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        NSString *text = [NSString stringWithFormat:@"Price: %@",
                          ((PFUser*)object)[@"price"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"name"]
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}


@end
