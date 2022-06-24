//
//  TweetCell.m
//  twitter
//
//  Created by Krishi Jain on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.likeButton.titleLabel.hidden = YES;
    self.replyButton.titleLabel.hidden = YES;
    self.retweetButton.titleLabel.hidden = YES;
    self.messageButton.titleLabel.hidden = YES;
    
    [self.likeButton addTarget:self action:@selector(didTapFavorite:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    // TODO: Update cell UI
    //💡 Try creating a refreshData() method in your cell that updates all of your views, i.e. sets the labels to their respective text, etc.
    
    // TODO: Send a POST request to the POST favorites/create endpoint
     [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             self.tweet.favoriteCount -= 1;
             [self refreshData];
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    // TODO: Update cell UI
    
    // TODO: Send a POST request to the POST favorites/create endpoint
     [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             self.tweet.retweetCount -= 1;
             [self refreshData];
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
    [self refreshData];
}

-(void)refreshData {
    self.likeCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
}

@end
