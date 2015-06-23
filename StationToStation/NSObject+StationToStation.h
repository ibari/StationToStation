#import <Foundation/Foundation.h>

// Stupid hack to get around Rdio API client bug

@interface NSObject (StupidFooBar)
- (int)count;
- (void) getObjects:(id *) objects andKeys:(id *) keys;
@end