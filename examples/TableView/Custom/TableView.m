#import "TableView.h"

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "RCTEventDispatcher.h"
#import "RCTLog.h"
#import "TableCell.h"

@interface TableView () <ASTableViewDataSource, ASTableViewDelegate>
{
  
}

@end

@implementation TableView
{
  RCTEventDispatcher *_eventDispatcher;
  UIView *_testView;
  ASTableView *_tableView;
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  RCTAssertParam(eventDispatcher);
  
  if ((self = [super initWithFrame:CGRectZero])) {
    super.backgroundColor = [UIColor blackColor];
    
    _tableView = [[ASTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain asyncDataFetching:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.asyncDataSource = self;
    _tableView.asyncDelegate = self;
    
    [self addSubview:_tableView];
  }
  
  return self;
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"Herex");
//  ASCellNode *node = [[ASCellNode alloc] init];
//  
//  node.frame = CGRectMake(0, 0, 100, 100);
//  
//  ASDisplayNode *test = [[ASDisplayNode alloc] init];
//  
//  test.backgroundColor = [UIColor redColor];
//  
//  [node addSubnode:test];
//  node.backgroundColor = [UIColor blueColor];
//  
//  return node;
  return [[TableCell alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (void)tableView:(UITableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context
{
  NSLog(@"adding kitties");
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
      
      // populate a new array of random-sized kittens
      NSArray *moarKittens = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
      
      NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
      
      // find number of kittens in the data source and create their indexPaths
      NSInteger existingRows = 0;
      
      for (NSInteger i = 0; i < moarKittens.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:existingRows + i inSection:0]];
      }
      
      [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
      
      [context completeBatchFetching:YES];
      
      NSLog(@"kittens added");
    });
  });
}

@end