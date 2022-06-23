//
//  DetailViewController.h
//  twitter
//
//  Created by Aman Abraham on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *like_button;
@property (weak, nonatomic) IBOutlet UIButton *retweet_button;
@property (nonatomic, strong) Tweet *tweeter;
@end

NS_ASSUME_NONNULL_END
