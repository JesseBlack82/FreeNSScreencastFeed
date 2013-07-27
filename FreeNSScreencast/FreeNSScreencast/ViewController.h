//
//  ViewController.h
//  FreeNSScreencast
//
//  Created by Jesse Stevens Black on 7/26/13.
//  Copyright (c) 2013 Jesse Stevens Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UITableViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate, MPMediaPlayback>

@property (nonatomic, strong) MPMoviePlayerViewController *mpvc;
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *entries;
@end
