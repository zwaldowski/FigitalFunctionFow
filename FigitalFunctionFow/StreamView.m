//
//  StreamView.m
//  FigitalFunctionFow
//

#import "StreamView.h"
#import "DFRGuesswork.h"

@interface StreamView () {
    CGDisplayStreamRef _displayStream;
}

@end

@implementation StreamView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.window.colorSpace = [NSColorSpace displayP3ColorSpace];
    CALayer *lyrr = [CALayer layer];
    lyrr.contents = kCAGravityResizeAspect;
    lyrr.backgroundColor = [[NSColor blackColor] CGColor];
    self.layer = lyrr;
    self.wantsLayer = YES;
}

- (void)dealloc {
    [self stopStreaming];
}

- (void)startStreaming {
    __weak StreamView *weakSelf = self;
    _displayStream = SLSDFRDisplayStreamCreate(nil, dispatch_get_main_queue(), ^(int dontCare1, unsigned long long dontCare2, IOSurfaceRef surface, CGDisplayStreamUpdateRef update){
        StreamView *strongSelf = weakSelf;
        if (!strongSelf) { return; }

        [CATransaction begin];
        CATransaction.disableActions = YES;
        strongSelf.layer.contents = (__bridge id)surface;
        [CATransaction commit];
    });
    DFRSetStatus(DFRStatusLockedAndLoaded);
    CGDisplayStreamStart(_displayStream);
}

- (void)stopStreaming {
    if (_displayStream == NULL) { return; }
    DFRSetStatus(DFRStatusNah);
    CGDisplayStreamStop(_displayStream);
    CFRelease(_displayStream);
    _displayStream = NULL;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event {
    return YES;
}

- (void)handleMouseEvent:(NSEvent *)event {
    CGEventRef cgEvent = [event CGEvent];
    if (cgEvent == NULL) { return; }
    CGPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    DFRFoundationPostEventWithMouseActivity(CGEventGetType(cgEvent), point);
}

- (void)mouseDown:(NSEvent *)event {
    [self handleMouseEvent:event];
}

- (void)mouseDragged:(NSEvent *)event {
    [self handleMouseEvent:event];
}

- (void)mouseUp:(NSEvent *)event {
    [self handleMouseEvent:event];
}

@end
