//
//  StellarRequestFileDetail.h
//  Hoppit
//
//  Created by Steven Preston on 2/15/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface StellarRequestFileDetail : NSObject

@property (strong, nonatomic) NSData *data;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *filename;
@property (copy, nonatomic) NSString *mimeType;

@end
