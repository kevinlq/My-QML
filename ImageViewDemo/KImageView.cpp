#include "KImageView.h"
#include "KManager.h"

// Qt lib
#include <QPainter>

KImageView::KImageView(QQuickItem *parent)
    :QQuickPaintedItem(parent)
    , m_nViewID(-1)
{
    connect(this, SIGNAL(signalRedraw()),
            this, SLOT(update()));
}

KImageView::~KImageView()
{
}

void KImageView::paint(QPainter *pPainter)
{
    KManager::getInstance()->drawImage(pPainter, QRect(0, 0, this->width(), this->height()));
}

int KImageView::nViewId()
{
    return m_nViewID;
}

void KImageView::setViewId(int nViewID)
{
    m_nViewID   = nViewID;
}
