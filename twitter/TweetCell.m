//
//  TweetCell.m
//  twitter
//
//  Created by Aman Abraham on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TimelineViewController.h"

@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapFavorite:(id)sender {//if tapped favorite button refresh
    if (self.tweet.favorited == YES){//if already favorited, unfavorite
        self.tweet.favorited = NO;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshFavorite];
            }
        }];
    }else{//if not favorited, favorite
        self.tweet.favorited = YES;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshFavorite];
            }
        }];
    }
}
- (IBAction)didTapReTweet:(id)sender {
    if (self.tweet.retweeted == YES){//if already retweeted, unretweet
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshTweet];
            }
        }];
    }else{//if not retweet, retweet
    self.tweet.retweeted = YES;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshTweet];
            }
        }];
    }
}

-(void) refreshTweet {//if its already retweeted, change to grey/ if not change to green icon and change count respectfully
    if (self.tweet.retweeted == YES){
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    }if(self.tweet.retweeted == NO){
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    }
}

-(void) refreshFavorite {//if its already liked, change to grey/ if not change to red icon and change count respectfully
if (self.tweet.favorited == YES){
    [self.likebutton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState: UIControlStateNormal];
    self.favorite_count.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
}if (self.tweet.favorited == NO){
    [self.likebutton setImage:[UIImage imageNamed:@"favor-icon.png"] forState: UIControlStateNormal];
    self.favorite_count.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
}
}

@end
