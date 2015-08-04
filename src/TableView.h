#import "RCTView.h"

@class RCTEventDispatcher;

@interface TableView : RCTView

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end