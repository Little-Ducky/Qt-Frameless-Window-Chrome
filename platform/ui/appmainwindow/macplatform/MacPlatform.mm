#include "MacPlatform.h"

#include <AppKit/AppKit.h>

MacPlatform::MacPlatform(QWindow *parent)
    : AppMainWindow(parent)
{
}

bool MacPlatform::nativeEvent(const QByteArray &type,
                                void *message,
                                qintptr *result)
{
    if (MacUtils::isInResizeArea(mapFromGlobal(QCursor::pos()), size()))
    {
      return false;
    }

    if (macUtils.resizeModeActive())
    {
      return true;
    }

    NSEvent* event = static_cast<NSEvent*>(message);

    NSView *view =
        (__bridge NSView *)(reinterpret_cast<void *>(winId()));

    NSWindow *window = view.window;

    if ([event type] == NSEventTypeLeftMouseDown)
    {
        NSButton *closeButton =
            [window standardWindowButton:NSWindowCloseButton];

        NSButton *miniButton =
            [window standardWindowButton:NSWindowMiniaturizeButton];

        NSButton *zoomButton =
            [window standardWindowButton:NSWindowZoomButton];

        NSPoint p = [event locationInWindow];

        constexpr int Border = 4;
        constexpr int Corner = Border * 2;

        NSView *titleBarView = closeButton.superview;

        NSPoint localPoint =
            [titleBarView convertPoint:p fromView:nil];

        bool overTrafficLights =
            NSPointInRect(localPoint, closeButton.frame) ||
            NSPointInRect(localPoint, miniButton.frame) ||
            NSPointInRect(localPoint, zoomButton.frame);

        if ([event clickCount] == 2)
        {
            NSString *action =
                [[NSUserDefaults standardUserDefaults]
                    stringForKey:@"AppleActionOnDoubleClick"];

            if ([action isEqualToString:@"Minimize"])
            {
                [window miniaturize:nil];
            }
            else if ([action isEqualToString:@"Maximize"] ||
                     [action isEqualToString:@"Zoom"] ||
                     [action isEqualToString:@"Fill"])
            {
                [window zoom:nil];
            }

            return true;
        }

        if (!overTrafficLights &&
            mapFromGlobal(QCursor::pos()).y() < m_appCaption->height() &&
            !m_appCaption->findInteractiveAt(contentItem(),
                                             mapFromGlobal(QCursor::pos())))
        {
            [window performWindowDragWithEvent:event];

            return true;
        }
    }

    return QQuickWindow::nativeEvent(type, message, result);
}

// Placeholder for future macOS-specific initialization logic.
void MacPlatform::setup()
{
    NSView *view =
        (__bridge NSView *)(reinterpret_cast<void *>(winId()));

    NSWindow *window = view.window;

    auto applyStyle = ^(NSWindow *w)
    {
        w.styleMask |= NSWindowStyleMaskTitled;
        w.styleMask |= NSWindowStyleMaskFullSizeContentView;

        w.titleVisibility = NSWindowTitleHidden;
        w.titlebarAppearsTransparent = YES;
    };

    applyStyle(window);

    [[NSNotificationCenter defaultCenter]
        addObserverForName:NSWindowDidEnterFullScreenNotification
                    object:window
                     queue:nil
                usingBlock:^(NSNotification *note)
                           {
                               applyStyle((NSWindow *)note.object);
                           }];

    [[NSNotificationCenter defaultCenter]
        addObserverForName:NSWindowDidExitFullScreenNotification
                    object:window
                     queue:nil
                usingBlock:^(NSNotification *note)
                           {
                               applyStyle((NSWindow *)note.object);
                           }];

    [[NSNotificationCenter defaultCenter]
        addObserverForName:NSWindowWillStartLiveResizeNotification
                    object:window
                     queue:nil
                usingBlock:^(NSNotification *note)
                           {
                               this->macPlatform.setResizeModeActive(true);
                           }];

    [[NSNotificationCenter defaultCenter]
        addObserverForName:NSWindowDidEndLiveResizeNotification
                    object:window
                     queue:nil
                usingBlock:^(NSNotification *note)
                           {
                               this->macPlatform.setResizeModeActive(false);
                           }];
}