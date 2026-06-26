#include "MacUtils.h"

MacUtils::MacUtils()
{
}

void MacUtils::setResizeModeActive(bool active)
{
    m_resizeModeActive = active;
}

bool MacUtils::resizeModeActive()
{
    return m_resizeModeActive;
}

bool MacUtils::isInResizeArea(const QPointF& p, const QSizeF& size)
{
    constexpr qreal Border = 4.0;
    constexpr qreal Corner = Border * 4.0;

    const qreal x = p.x();
    const qreal y = p.y();

    const qreal w = size.width();
    const qreal h = size.height();

    if (x <= Corner && y <= Corner &&
        (x > Border || y > Border))
    {
        return true;
    }

    if (x >= w - Corner && y <= Corner &&
        (x < w - Border || y > Border))
    {
        return true;
    }

    if (x <= Corner && y >= h - Corner &&
        (x > Border || y < h - Border))
    {
        return true;
    }

    if (x >= w - Corner && y >= h - Corner &&
        (x < w - Border || y < h - Border))
    {
        return true;
    }

    if (x <= Border)
        return true;

    if (x >= w - Border)
        return true;

    if (y <= Border)
        return true;

    if (y >= h - Border)
        return true;

    return false;
}