//
//  TweetCell.h
//  twitter
//
//  Created by Aman Abraham on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profile_image_url_https;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *created_at;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *retweet_count;
@property (weak, nonatomic) IBOutlet UILabel *favorite_count;

@end

NS_ASSUME_NONNULL_END
