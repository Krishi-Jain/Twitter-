//
//  User.m
//  twitter
//
//  Created by Krishi Jain on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@interface User()

@end

// TODO: Add properties
@implementation User

// TODO: Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePictureURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        
        NSData *urlData = [NSData dataWithContentsOfURL:self.profilePictureURL];
        self.profileImage = [UIImage imageWithData:urlData];
    }
    return self;
}
@end
