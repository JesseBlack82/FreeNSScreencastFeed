//
//  FeedEntry.m
//  FreeNSScreencast
//
//  Created by Jesse Stevens Black on 7/27/13.
//  Copyright (c) 2013 Jesse Stevens Black. All rights reserved.
//

#import "FeedEntry.h"

@implementation FeedEntry
- (id)init
{
    self = [super init];
    if (self)   {
        _currentString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_title forKey:@"title"];
	[aCoder encodeObject:_link forKey:@"link;"];
	[aCoder encodeObject:_content forKey:@"content"];
	[aCoder encodeObject:_author forKey:@"author"];
	[aCoder encodeObject:_published forKey:@"published"];
	[aCoder encodeObject:_updated forKey:@"updated"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)   {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.link = [aDecoder decodeObjectForKey:@"link;"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.published = [aDecoder decodeObjectForKey:@"published"];
        self.updated = [aDecoder decodeObjectForKey:@"updated"];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"starting element %@", elementName);
    if ([elementName compare:@"link"] == NSOrderedSame) {
        self.link = attributeDict[@"href"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"entry"])    {
        parser.delegate = _parentParserDelegate;
    } else if ([elementName isEqualToString:@"title"])  {
        self.title = _currentString;
    } else if ([elementName isEqualToString:@"content"])    {
        self.content = _currentString;
    } else if ([elementName isEqualToString:@"name"]) {
        self.author = _currentString;
    } else if ([elementName isEqualToString:@"published"])  {
        self.published = _currentString;
    } else if ([elementName isEqualToString:@"updated"])    {
        self.currentString = [NSMutableString string];
    }
}

@end
