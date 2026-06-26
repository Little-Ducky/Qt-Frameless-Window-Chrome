#ifndef MACPLATFORM_H
#define MACPLATFORM_H

#include "platform/IPlatform.h"

#include "../AppMainWindow.h"

#include "utils/MacUtils.h"

class MacPlatform : public IPlatform,
                    public AppMainWindow
{
public:
    explicit MacPlatform(QWindow *parent = nullptr);

    void Q_INVOKABLE setup() override;

protected:
    bool nativeEvent(const QByteArray &eventType,
                     void *message,
                     qintptr *result) override;

private:
    MacUtils macUtils;
};

#endif // MACPLATFORM_H
