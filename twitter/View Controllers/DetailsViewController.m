//
//  DetailsViewController.m
//  twitter
//
//  Created by Krishi Jain on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "TimelineViewController.h"
#import "User.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDetails;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    [self setupDetailView];
}
-(void) setupDetailView {
    self.profileName.text = self.tweet.user.name;
    self.userName.text = self.tweet.user.screenName;
    self.tweetDetails.text = self.tweet.text;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.date.text = self.tweet.createdAtString;

    NSString *URLString = self.tweet.user.profileImage;
    //NSString *URLString = [self.tweet.user.profileImage stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    //[self.profileImage setImageWithURL: urlNew];
    self.profileImage.image = [UIImage imageWithData:urlData];
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderWidth = 0;
}

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error UNretweeting tweet: %@", error.localizedDescription); // error statemenet needed
            }
            else{
                NSLog(@"Successfully Unretweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshLike];
            }
        }];
    } else {
    self.tweet.favorited = YES;
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshLike];
        }
    }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error UNretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully Unretweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshRetweet];
            }
        }];
    } else {
    self.tweet.retweeted = YES;
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshRetweet];
        }
    }];
    }
}

-(void)refreshLike {
    if (self.tweet.favorited == YES){
        self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.likeDetails setImage:[UIImage imageNamed:@"favor-icon-red.png"]forState:UIControlStateNormal];
    }
    if (self.tweet.favorited == NO){
        self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.likeDetails setImage:[UIImage imageNamed:@"favor-icon.png"]forState:UIControlStateNormal];
    }

}

- (void) refreshRetweet {
    if (self.tweet.retweeted == YES) {
        self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweetDetails setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted == NO){
        self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweetDetails setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)didExit:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
