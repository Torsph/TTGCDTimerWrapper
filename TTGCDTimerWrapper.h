@interface TTGCDTimerWrapper : NSObject

//Either a dispatch queue is provided or a default dispatch queue
//will be used. (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);)
- (id)initWithTargetQueue:(dispatch_queue_t)targetQueue;

//Will perform a block on the provided queue (or default queue) after a given interval.
//One can also set it to repeat.
- (void)afterInterval:(NSTimeInterval)interval perform:(void (^)())block repeats:(BOOL) repeats;

//Will cancel the timer and if needed the targetQueue is released.
- (void)cancel;

@end