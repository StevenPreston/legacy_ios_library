//
//  StellarLocation.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

@interface StellarLocation : NSObject <NSCoding>

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end
