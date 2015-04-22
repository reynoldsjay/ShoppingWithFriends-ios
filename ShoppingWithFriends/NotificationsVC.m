//
//  NotificationsVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/22/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "NotificationsVC.h"
#import <Parse/Parse.h>

@interface NotificationsVC ()

@property IBOutlet UITableView *tableView;

@end

@implementation NotificationsVC {

    NSMutableArray *notifications;
    
}

-(void)viewDidLoad {
    if (!notifications) {
        notifications = [[NSMutableArray alloc] init];
    }
    
    [[PFUser currentUser] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSMutableArray *wl = object[@"WishList"];
        for (PFObject *item in wl) {
            [item fetchIfNeededInBackgroundWithBlock:^(PFObject *theItem, NSError *error) {
                PFQuery *query = [PFQuery queryWithClassName:@"SalesReport"];
                [query whereKey:@"name" equalTo:theItem[@"name"]];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        for (PFObject *match in objects) {
                            if ([(NSNumber *)match[@"price"] intValue] <= [(NSNumber*)theItem[@"price"] intValue]) {
                                [notifications addObject:match];
                                NSLog(@"%@", match[@"location"]);
                                
                                
                            }
                            
                        }
                        
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                    
                    [self.tableView reloadData];
                }];
                
            }];
        }
        
        
        
    }];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [[notifications objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        cell.textLabel.text = object[@"name"];
    }];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[notifications objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        NSString *text = [NSString stringWithFormat:@"Price: %@ \n Location: %@",
                          ((PFUser*)object)[@"price"], ((PFUser*)object)[@"location"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"name"]
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}


@end
