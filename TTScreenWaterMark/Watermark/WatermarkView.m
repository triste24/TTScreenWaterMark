//
//  WatermarkView.m
//  ScreenWatermark
//
//  Created by triste on 2023/3/27.
//

#import "WatermarkView.h"
const CGFloat kDefaultFontSize = 12;

@interface WatermarkSubView ()
@property (nonatomic) NSAttributedString *displayString;
@end

@implementation WatermarkSubView

-(void)drawRect:(NSRect)dirtyRect {

    [super drawRect:dirtyRect];

    [[NSColor clearColor] set];

    NSAffineTransform *xform = [NSAffineTransform transform];
    [xform rotateByDegrees:30];
    [xform concat];

    CGSize titleSize = [self.title sizeWithAttributes:@{NSFontAttributeName:[NSFont systemFontOfSize:kDefaultFontSize]}];

    [self.displayString drawAtPoint:NSMakePoint(titleSize.width, 0)];
}

-(NSAttributedString *)displayString {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.title];

    [title addAttributes:@{NSForegroundColorAttributeName:self.titleColor,
                           NSFontAttributeName:[NSFont systemFontOfSize:kDefaultFontSize]}
                   range:NSMakeRange(0, self.title.length)];

    return title;
}

-(void)setDisplayString:(NSAttributedString *)displayString {
    NSDictionary *dicAttibutes = [displayString attributesAtIndex:0 effectiveRange:NULL];
    self.title = displayString.string;
    for (NSString *key in dicAttibutes.allKeys) {
        if ([key isEqualToString:NSForegroundColorAttributeName]) {
            self.titleColor = dicAttibutes[NSForegroundColorAttributeName];
        }
    }
}

@end

@implementation WatermarkView

- (instancetype)initWithFrame:(NSRect)frameRect showTitle:(NSString *)title titleColor:(NSColor *)titleColor {
    self = [super init];
    if (self) {
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[NSFont systemFontOfSize:kDefaultFontSize]}];

        float row = frameRect.size.width / titleSize.width;
        float col = frameRect.size.height / titleSize.width;

        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                WatermarkSubView *markView = [[WatermarkSubView alloc] initWithFrame:
                                              CGRectMake(i * titleSize.width * 3,
                                                         j * titleSize.width * 3,
                                                         titleSize.width * 3,
                                                         titleSize.width * 3)];
                markView.title      = title;
                markView.titleColor = titleColor;
                [self addSubview:markView];
            }
        }
    }
    return self;
}

+(instancetype)viewWithFrame:(CGRect)frameRect showTitle:(NSString *)title titleColor:(NSColor *)titleColor {

    return [[self alloc] initWithFrame:frameRect showTitle:title titleColor:titleColor];
}

+ (void)displayScreenWatermark:(NSString *)title titleColor:(NSColor *)titleColor {
    for (NSScreen *screen in [NSScreen screens]) {
        
        NSWindow *window = [[NSPanel alloc] initWithContentRect:[screen frame]
                                                      styleMask:NSWindowStyleMaskBorderless | NSWindowStyleMaskNonactivatingPanel
                                                        backing:NSBackingStoreBuffered
                                                          defer:NO];
        
        WatermarkView *view = [WatermarkView viewWithFrame:[screen frame]
                                                 showTitle:title
                                                titleColor:titleColor];
        
        [window setContentView:view];
        [window setOpaque:NO];
        [window setBackgroundColor:[NSColor clearColor]];
        [window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces |
         NSWindowCollectionBehaviorFullScreenAuxiliary];
        [window setIgnoresMouseEvents:YES];
        [window setHasShadow:NO];
        [window setLevel:NSScreenSaverWindowLevel];
        [window makeKeyAndOrderFront:nil];
    }
}

@end
