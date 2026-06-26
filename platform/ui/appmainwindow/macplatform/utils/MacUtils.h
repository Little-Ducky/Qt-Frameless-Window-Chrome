#ifndef MACUTILS_H
#define MACUTILS_H

#include <QObject>
#include <QPointF>
#include <QSize>

class MacUtils
{
public:
    MacUtils();

    void setResizeModeActive(bool active);
    bool resizeModeActive();

    static bool isInResizeArea(const QPointF& p, const QSizeF& size);

private:
    bool m_resizeModeActive = false;
};

#endif // MACUTILS_H
