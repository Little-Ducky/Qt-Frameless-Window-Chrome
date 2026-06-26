#ifndef LINUXPLATFORM_H
#define LINUXPLATFORM_H

#include "platform/IPlatform.h"

#include "../AppMainWindow.h"

class LinuxPlatform : public IPlatform, public AppMainWindow
{
    Q_OBJECT

public:
    explicit LinuxPlatform(QWindow *parent = nullptr);

    void Q_INVOKABLE setup() override;

protected:
    bool nativeEvent(const QByteArray &eventType,
                     void *message,
                     qintptr *result) override;
};


#endif // LINUXPLATFORM_H
