
#import <Cocoa/Cocoa.h>

@interface RevealButtonCell : NSTextFieldCell {
@private
    BOOL iMouseDownInInfoButton;
    BOOL iMouseHoveredInInfoButton;
    SEL iInfoButtonAction;
}
- (SEL)infoButtonAction;
- (void)setInfoButtonAction:(SEL)action;

- (NSRect)infoButtonRectForBounds:(NSRect)bounds;

- (void)addTrackingAreasForView:(NSView *)controlView inRect:(NSRect)cellFrame withUserInfo:(NSDictionary *)userInfo mouseLocation:(NSPoint)mouseLocation;

- (void)setMouseEntered:(BOOL)y;
@end
