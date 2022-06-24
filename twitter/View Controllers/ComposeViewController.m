//
//  ComposeViewController.m
//  twitter
//
//  Created by Aman Abraham on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *composeTweet;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;


@end

@implementation ComposeViewController
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButton:(id)sender {//if pressed tweet button will send
    [[APIManager shared]postStatusWithText: self.composeTweet.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.composeTweet becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {//character Limit
    NSString *substring = [NSString stringWithString:self.composeTweet.text];
    if (substring.length > 0) {
        self.characterCount.hidden = NO;
        self.characterCount.text = [NSString stringWithFormat:@"%d characters used", substring.length];
    }
    if (substring.length == 0) {
        self.characterCount.hidden = YES;
    }
    if (substring.length == 140) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You have used too many characters in your tweet!" message:@"Character limit is 140 tweet." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        self.characterCount.textColor = [UIColor redColor];
    }
    if (substring.length < 15) {
        self.characterCount.textColor = [UIColor greenColor];
    }
}

@end
