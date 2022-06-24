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
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profile_image_url_https addGestureRecognizer:profileTapGestureRecognizer];
    [self.profile_image_url_https setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited == YES){
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
    }else{
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
    if (self.tweet.retweeted == YES){
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
    }else{
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

-(void) refreshTweet {
    if (self.tweet.retweeted == YES){
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    }if(self.tweet.retweeted == NO){
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState: UIControlStateNormal];
        self.retweet_count.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    }
}

-(void) refreshFavorite {
if (self.tweet.favorited == YES){
    [self.likebutton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState: UIControlStateNormal];
    self.favorite_count.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
}if (self.tweet.favorited == NO){
    [self.likebutton setImage:[UIImage imageNamed:@"favor-icon.png"] forState: UIControlStateNormal];
    self.favorite_count.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
}
}



- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}



@end
