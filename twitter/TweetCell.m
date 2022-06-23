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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshView];
        }
    }];
}
- (IBAction)didTapReTweet:(id)sender {
    
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshView];
        }
    }];
}

-(void) refreshView {
    if (self.tweet.retweeted == YES){
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState: UIControlStateNormal];
    }else{
        [self.tweetbutton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState: UIControlStateNormal];
    }
    if (self.tweet.favorited == YES){
        [self.likebutton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState: UIControlStateNormal];
    }else{
        [self.likebutton setImage:[UIImage imageNamed:@"favor-icon.png"] forState: UIControlStateNormal];
    }
}


@end
