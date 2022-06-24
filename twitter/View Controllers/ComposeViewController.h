//
//  ComposeViewController.h
//  twitter
//
//  Created by Aman Abraham on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "ComposeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController:UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
