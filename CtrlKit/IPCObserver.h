#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKIPCObserver : NSObject

- (instancetype)initWithNotification:(const char *)name;
- (void)startMonitoring;
- (void)stopMonitoring;

@end

NS_ASSUME_NONNULL_END
