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
@property (weak, nonatomic) IBOutlet UILabel *like_count;
@property (weak, nonatomic) IBOutlet UILabel *retweet_count;

@end

@implementation DetailViewController

- (IBAction)retweetbutton:(id)sender {
    if (self.tweeter.retweeted == YES){//if already tweet switch to untweeting
        self.tweeter.retweeted = NO;
        [[APIManager shared] unretweet:self.tweeter completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweeter = tweet;
                [self refreshTweet];
            }
        }];
    }else{//if not retweeted, retweet
    self.tweeter.retweeted = YES;
        [[APIManager shared] retweet:self.tweeter completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweeter = tweet;
                [self refreshTweet];
            }
        }];
    }
}
- (IBAction)likebutton:(id)sender {
    if (self.tweeter.favorited == YES){//if already liked, unlike
        self.tweeter.favorited = NO;
        [[APIManager shared] unfavorite:self.tweeter completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweeter = tweet;
                [self refreshFavorite];
            }
        }];
    }else{//if unliked, like
        self.tweeter.favorited = YES;
        [[APIManager shared] favorite:self.tweeter completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweeter = tweet;
                [self refreshFavorite];
            }
        }];
    }
}
-(void) refreshTweet {//changes image and count of retweet if button is clicked
    if (self.tweeter.retweeted == YES){
        [self.retweet_button setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweeter.retweetCount];
    }if(self.tweeter.retweeted == NO){
        [self.retweet_button setImage:[UIImage imageNamed:@"retweet-icon.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweeter.retweetCount];
    }
}

-(void) refreshFavorite {//changes image and count of favorite if button is clicked
if (self.tweeter.favorited == YES){
    [self.like_button setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState: UIControlStateNormal];
    self.like_count.text = [NSString stringWithFormat: @"%d", self.tweeter.favoriteCount];
}if (self.tweeter.favorited == NO){
    [self.like_button setImage:[UIImage imageNamed:@"favor-icon.png"] forState: UIControlStateNormal];
    self.like_count.text = [NSString stringWithFormat: @"%d", self.tweeter.favoriteCount];
}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Gets Objects
    self.dvtext.text = self.tweeter.text;
    self.dvuser_name.text = self.tweeter.user.name;
    self.dvscreen_name.text = self.tweeter.user.screenName;
    self.retweet_count.text = [NSString stringWithFormat:@"%d", self.tweeter.retweetCount];
    self.like_count.text = [NSString stringWithFormat:@"%d", self.tweeter.favoriteCount];
    //Gets images
    NSString *URLString = self.tweeter.user.profilePicture;
    NSString *stringWithoutNormal = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *urlNew = [NSURL URLWithString:stringWithoutNormal];
    [self.dvprofileView setImageWithURL: urlNew];
    //Makes image Circle
    self.dvprofileView.layer.cornerRadius = self.dvprofileView.frame.size.height/2;
    self.dvprofileView.layer.masksToBounds = YES;
    self.dvprofileView.layer.borderWidth = 0;

}


@end

