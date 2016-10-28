//
//  DFRGuesswork.h
//  FigitalFunctionFow
//

#ifndef DFRGuesswork_h
#define DFRGuesswork_h

@import QuartzCore;

typedef enum {
    DFRStatusNah = 0,
    DFRStatusLockedAndLoaded = 2
} DFRStatus;

extern CGDisplayStreamRef SLSDFRDisplayStreamCreate(CFAllocatorRef allocator, dispatch_queue_t queue, void(^handler)(int, unsigned long long, IOSurfaceRef, CGDisplayStreamUpdateRef));
extern void DFRSetStatus(DFRStatus status);
extern void DFRFoundationPostEventWithMouseActivity(CGEventType type, CGPoint point);
extern void DFRRegisterStatusChangeCallback(void(^handler)(void));
extern CGSize DFRGetScreenSize(void);

#endif /* DFRGuesswork_h */
