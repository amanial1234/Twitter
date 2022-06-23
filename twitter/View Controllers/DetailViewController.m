//
//  DetailViewController.m
//  twitter
//
//  Created by Aman Abraham on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dvtext;
@property (weak, nonatomic) IBOutlet UILabel *dvuser_name;
@property (weak, nonatomic) IBOutlet UILabel *dvscreen_name;
@property (weak, nonatomic) IBOutlet UIImageView *dvprofileView;
@property (weak, nonatomic) IBOutlet UIButton *dvlikebutton;
@property (weak, nonatomic) IBOutlet UIButton *dvretweetbutton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end

