//
//  User.h
//  twitter
//
//  Created by Krishi Jain on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// MARK: Properties

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profileImage;


// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// Add any additional properties here
@end

NS_ASSUME_NONNULL_END
