#ifndef DLog
  #ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
  #else
    #define DLog(...)
  #endif
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface NSException (JR_raiseDebugException)
+ (void)raiseJRDebugException:(NSString *)name format:(NSString *)format, ...;
@end