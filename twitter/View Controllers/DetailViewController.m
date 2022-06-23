//
//  DetailViewController.m
//  twitter
//
//  Created by Aman Abraham on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dvtext;
@property (weak, nonatomic) IBOutlet UILabel *dvuser_name;
@property (weak, nonatomic) IBOutlet UILabel *dvscreen_name;
@property (weak, nonatomic) IBOutlet UIImageView *dvprofileView;

@end

@implementation DetailViewController
- (IBAction)retweetbutton:(id)sender {
    self.tweeter.retweeted = YES;
    self.tweeter.retweetCount += 1;
    
    [[APIManager shared] retweet:self.tweeter completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            self.tweeter = tweet;
            [self refreshView];
        }
    }];
}
- (IBAction)likebutton:(id)sender {
    self.tweeter.favorited = YES;
    self.tweeter.favoriteCount += 1;
    
    [[APIManager shared] favorite:self.tweeter completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweeter = tweet;
            [self refreshView];
        }
    }];
}
-(void) refreshView {
    if (self.tweeter.retweeted == YES){
        [self.retweet_button setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState: UIControlStateNormal];
    }else{
        [self.retweet_button setImage:[UIImage imageNamed:@"retweet-icon.png"] forState: UIControlStateNormal];
    }
    if (self.tweeter.favorited == YES){
        [self.like_button setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState: UIControlStateNormal];
    }else{
        [self.like_button setImage:[UIImage imageNamed:@"favor-icon.png"] forState: UIControlStateNormal];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dvtext.text = self.tweeter.text;
    self.dvuser_name.text = self.tweeter.user.name;
    self.dvscreen_name.text = self.tweeter.user.screenName;
    
    NSString *URLString = self.tweeter.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.dvprofileView.image = [UIImage imageWithData:urlData];

}


@end

