//
//  FeedEntry.h
//  FreeNSScreencast
//
//  Created by Jesse Stevens Black on 7/27/13.
//  Copyright (c) 2013 Jesse Stevens Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedEntry : NSObject <NSXMLParserDelegate, NSCoding>
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, strong) id <NSXMLParserDelegate> parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *updated;
@end
