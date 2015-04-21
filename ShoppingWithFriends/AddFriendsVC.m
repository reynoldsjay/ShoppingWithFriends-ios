//
//  AddFriendsVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "AddFriendsVC.h"
#import <Parse/Parse.h>

@interface AddFriendsVC ()

@property IBOutlet UITableView *tableView;

@end

@implementation AddFriendsVC {

    NSMutableArray *allUsers;
    
}

-(void)viewDidLoad {
    [[PFUser currentUser] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSMutableArray *friends = object[@"Friends"];
        NSMutableArray *friendids = [[NSMutableArray alloc] init];

        for (PFUser *aFriend in friends) {
            [friendids addObject:aFriend.objectId];
        }

        
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" notContainedIn:friendids];
        [query whereKey:@"username" notEqualTo:[PFUser currentUser].username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                allUsers = [objects mutableCopy];
                
                [allUsers removeObjectsInArray:friends];
                [self.tableView reloadData];
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        

    }];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allUsers count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [[allUsers objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        cell.textLabel.text = object[@"Name"];
    }];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[allUsers objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        NSMutableArray *friends = [PFUser currentUser][@"Friends"];
        [friends addObject:object];
        [PFUser currentUser][@"Friends"] = friends;
        [[PFUser currentUser] saveInBackground];
    }];
    
    [self performSegueWithIdentifier:@"back" sender:self];
    
    
    
}

@end
