//
//  TweetCell.h
//  twitter
//
//  Created by Aman Abraham on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) Tweet *tweet;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *profile_image_url_https;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *created_at;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *retweet_count;
@property (weak, nonatomic) IBOutlet UILabel *favorite_count;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (nonatomic) BOOL retweeted;
@property (nonatomic) BOOL favorited;
@property (weak, nonatomic) IBOutlet UIButton *likebutton;
@property (weak, nonatomic) IBOutlet UIButton *tweetbutton;

@end

@protocol TweetCellDelegate
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
