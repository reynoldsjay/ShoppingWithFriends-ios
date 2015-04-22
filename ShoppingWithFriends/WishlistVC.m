//
//  WishlistVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "WishlistVC.h"
#import <Parse/Parse.h>


@interface WishlistVC ()

@property IBOutlet UITableView *tableView;

@end


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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PFUser *curUser = [PFUser currentUser];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [wlitems removeObjectAtIndex:indexPath.row];
        curUser[@"WishList"] = wlitems;
        [curUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
            } else {
                // There was a problem, check error.description
            }
            [self.tableView reloadData];
        }];
    }
    
}


@end
