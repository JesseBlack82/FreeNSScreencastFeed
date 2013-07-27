//
//  ViewController.m
//  FreeNSScreencast
//
//  Created by Jesse Stevens Black on 7/26/13.
//  Copyright (c) 2013 Jesse Stevens Black. All rights reserved.
//

#import "ViewController.h"

#import "AFHttpClient.h"

#import "FeedEntry.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName compare:@"entry"] == NSOrderedSame)    {
        FeedEntry *entry = [[FeedEntry alloc] init];
        [_entries addObject:entry];
        parser.delegate = entry;
        entry.parentParserDelegate = self;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName compare:@"feed"] == NSOrderedSame)  {
        [[self tableView] reloadData];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.entries = [NSMutableArray array];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://nsscreencast.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client getPath:@"feed" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        self.parser = [[NSXMLParser alloc] initWithData:responseObject];
        _parser.delegate = self;
        [_parser parse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Data Source
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    if (!cell)  {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FeedCell"];
    }
    FeedEntry *entry = [_entries objectAtIndex:indexPath.row];
    cell.textLabel.text = entry.title;
    cell.detailTextLabel.text = entry.content;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedEntry *entry = _entries[indexPath.row];
    NSURL *url = [NSURL URLWithString:entry.link];
    self.mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self.view addSubview:self.mpvc.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)moviePlayerFinished:(NSNotification *)note
{
    [self.mpvc.view removeFromSuperview];
    self.mpvc = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
@end
