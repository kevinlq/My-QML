#ifndef KIMAGEVIEW_H
#define KIMAGEVIEW_H

#include <QQuickPaintedItem>

class KImageView : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(int nViewId READ nViewId WRITE setViewId NOTIFY  viewIdChanged)

public:
    KImageView(QQuickItem *parent = 0);
    virtual ~KImageView();

    virtual void paint(QPainter *);

    int nViewId();
    void setViewId(int nViewID);

signals:
    void signalRedraw();
    void viewIdChanged();

private:
    int m_nViewID;
};

#endif // KIMAGEVIEW_H
