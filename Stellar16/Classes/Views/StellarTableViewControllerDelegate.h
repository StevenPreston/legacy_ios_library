//
//  StellarTableViewControllerDelegate.h
//  Hoppit
//
//  Created by Steven Preston on 7/24/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@protocol StellarTableViewControllerDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
