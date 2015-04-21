//
//  FriendsVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/21/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "FriendsVC.h"
#import <Parse/Parse.h>

@implementation FriendsVC {

    NSMutableArray *friends;
    PFUser *curUser;
    
}

-(void)viewDidLoad {
    curUser = [PFUser currentUser];
    friends = curUser[@"Friends"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[friends count]);
    return [friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    [[friends objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        cell.textLabel.text = object[@"Name"];
    }];

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[friends objectAtIndex:indexPath.row] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        NSString *text = [NSString stringWithFormat:@"Username: %@ \n\r Email: %@",
                          ((PFUser*)object).username, ((PFUser*)object).email];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"Name"]
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
