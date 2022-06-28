//
//  DetailsViewController.h
//  twitter
//
//  Created by Krishi Jain on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIButton *likeDetails;
@property (weak, nonatomic) IBOutlet UIButton *retweetDetails;

@end

NS_ASSUME_NONNULL_END
