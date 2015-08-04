//
//  TableCell.m
//  TableView
//
//

#import "TableCell.h"

@interface TableCell()
{
  ASTextNode *_textNode;
}
@end

@implementation TableCell

- (instancetype)init
{
  if (!(self = [super init]))
    return nil;

  NSLog(@"herex");

  self.backgroundColor = [UIColor redColor];

  _textNode = [[ASTextNode alloc] init];
  NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:@"Testing"];
  _textNode.attributedString = [[NSAttributedString alloc] initWithAttributedString:myString];

  [self addSubnode:_textNode];

  return self;
}

#if UseAutomaticLayout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{

  _textNode.flexShrink = NO;

  return
  [ASInsetLayoutSpec
   newWithInsets:UIEdgeInsetsMake(kOuterPadding, kOuterPadding, kOuterPadding, kOuterPadding)
   child:
   [ASStackLayoutSpec
    newWithStyle:{
      .direction = ASStackLayoutDirectionHorizontal,
      .spacing = kInnerPadding
    }
    children:@[_textNode]]];
}

// With box model, you don't need to override this method, unless you want to add custom logic.
- (void)layout
{
  [super layout];
  _textNode.frame = CGRectMake(0.0f, 0.0f, 320, 50);
}
#else
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  return CGSizeMake(320, 50);
}

- (void)layout
{
  _textNode.frame = CGRectMake(0, 0, 320, 50);
}
#endif

@end
