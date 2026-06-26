#include "LinuxPlatform.h"

// Linux implementation of AppMainWindow
// Currently relies on the default system window manager behavior (X11/Wayland).
// Standard title bar, borders, and window controls are handled by the OS compositor.
// In the future, this can be extended to support a custom frameless window implementation
// similar to the Windows version.
LinuxPlatform::LinuxPlatform(QWindow *parent)
    : AppMainWindow(parent)
{
}

// Native event handling is not customized on Linux at the moment.
// All window management events are processed by the default Qt / system window manager.
bool LinuxPlatform::nativeEvent(const QByteArray& eventType,
                                void *message,
                                qintptr *result)
{
    return QQuickWindow::nativeEvent(eventType, message, result);
}

// Placeholder for Linux-specific initialization logic.
void LinuxPlatform::setup()
{
}

