#import "IPCObserver.h"
#include <notify.h>
#include <mach/mach.h>

@interface CKIPCObserver () {
    int _token;
    mach_port_t _port;
    dispatch_source_t _source;
    const char *_name;
}
@end

@implementation CKIPCObserver

- (instancetype)initWithNotification:(const char *)name {
    self = [super init];
    if (self) {
        _name = name;
        _token = 0;
        _port = MACH_PORT_NULL;
        _source = nil;
    }
    return self;
}

- (void)startMonitoring {
    if (_token) return;
    if (notify_register_mach_port(_name, &_port, 0, &_token) == NOTIFY_STATUS_OK) {
        _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_MACH_RECV, _port, 0, dispatch_get_main_queue());
        dispatch_source_set_event_handler(_source, ^{
            mach_msg_header_t msg;
            mach_msg(&msg, MACH_RCV_MSG, 0, sizeof(msg), _port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
            NSLog(@"Received notification: %s", _name);
        });
        dispatch_resume(_source);
    }
}

- (void)stopMonitoring {
    if (_token) {
        notify_cancel(_token);
        _token = 0;
    }
    if (_source) {
        dispatch_source_cancel(_source);
        _source = nil;
    }
    if (_port != MACH_PORT_NULL) {
        mach_port_deallocate(mach_task_self(), _port);
        _port = MACH_PORT_NULL;
    }
}

@end
