#import "TTGCDTimerWrapper.h"

@implementation TTGCDTimerWrapper {
    dispatch_queue_t _queue;
    dispatch_source_t _timer;
}

- (id)initWithTargetQueue:(dispatch_queue_t)targetQueue {
	self = [super init];
	
	if(self) {
		_queue = targetQueue ?:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     	_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    }
    return self;
}

- (void) afterInterval: (NSTimeInterval)interval perform:(void (^)())block repeats:(BOOL) repeats {
    [self performSync: ^{
        
        NSTimeInterval timeIntervalInNSec = interval * NSEC_PER_SEC;
        
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, timeIntervalInNSec), timeIntervalInNSec, 0);
        
        dispatch_source_set_event_handler(_timer, ^{
            if(block){
                block();
            }
            if (!repeats) {
                [self cancel];
            }
        });
        
        dispatch_resume(_timer);
    }];
}

- (void)performSync: (dispatch_block_t)block {
    dispatch_sync(_queue, block);
}

- (void)cancel {
    [self performSync: ^{
	    if(_timer) {
	        dispatch_source_cancel(_timer);

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
	        dispatch_release(_timer);
#endif
	        _timer = NULL;
	    }
    }];
}

- (void)dealloc {
    [self cancel];
    _queue = NULL;
}
@end