//
//  TableViewManager.m
//  TableView
//
//

#import "TableView.h"
#import "TableViewManager.h"

#import "RCTBridge.h"

@implementation TableViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[TableView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}


@end
