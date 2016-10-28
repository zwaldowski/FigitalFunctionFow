//
//  ViewController.m
//  FigitalFunctionFow
//

#import "ViewController.h"
#import "StreamView.h"
#import "DFRGuesswork.h"

@interface ViewController ()

@property IBOutlet StreamView *streamView;
@property IBOutlet NSLayoutConstraint *widthConstraint;
@property IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DFRRegisterStatusChangeCallback(^{
        CGSize size = DFRGetScreenSize();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (size.width > 0) {
                self.widthConstraint.constant = size.width;
            }

            if (size.height > 0) {
                self.heightConstraint.constant = size.height;
            }
        });
    });
}

- (void)viewWillAppear {
    [super viewWillAppear];

    self.view.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    self.view.window.movableByWindowBackground = YES;
    [self.streamView startStreaming];
}

- (void)viewDidDisappear {
    [super viewDidDisappear];
    [self.streamView stopStreaming];
}

@end
