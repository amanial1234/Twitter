//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"


@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (IBAction)didtapLogout:(UIButton *)sender;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchTweets];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void) fetchTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                self.arrayOfTweets = (NSMutableArray *)tweets;
                
                [self.tableView reloadData];
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didTweet:(Tweet *)tweet{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [self.arrayOfTweets addObject:tweet];
    [self.tableView reloadData];
}

- (IBAction)didtapLogout:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    //Get Objects
    cell.tweet = tweet;
    cell.name.text = tweet.user.name;
    cell.screen_name.text= tweet.user.screenName;
    cell.text.text = tweet.text;
    cell.retweet_count.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.favorite_count.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.created_at.text = tweet.createdAtString;
    cell.retweeted = tweet.retweeted;
    cell.favorited = tweet.favorited;
    //Get Image
    NSString *URLString = tweet.user.profilePicture;
    NSString *stringWithoutNormal = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *urlNew = [NSURL URLWithString:stringWithoutNormal];
    [cell.profile_image_url_https setImageWithURL: urlNew];
    //Makes image Circle
    cell.profile_image_url_https.layer.cornerRadius = cell.profile_image_url_https.frame.size.height/2;
    cell.profile_image_url_https.layer.masksToBounds = YES;
    cell.profile_image_url_https.layer.borderWidth = 0;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetails"]){//if going to details page
        TweetCell *cell = sender;
        NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
        Tweet *dataToPass = self.arrayOfTweets[indexpath.row];
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.tweeter = dataToPass;
    }else{//if going to compose
   UINavigationController *navigationController = [segue destinationViewController];
   ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
   composeController.delegate = self;
    }
}
@end
