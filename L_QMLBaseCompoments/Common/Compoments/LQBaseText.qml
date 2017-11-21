import QtQuick 2.2

Item {
    id: _baseText
    clip: true

    width: textWH.width
    height: textWH.height

    property alias horizontalAlignment: contentTextId.horizontalAlignment
    property alias verticalAlignment:contentTextId.verticalAlignment
    property string text: ""
    property alias wrapMode: contentTextId.wrapMode
    property alias color: contentTextId.color
    property alias contentHeight : contentTextId.contentHeight
    property alias contentWidth : contentTextId.contentWidth
    property alias elide: contentTextId.elide //Text.ElideRight
    property alias font: contentTextId.font
    property alias style : contentTextId.style
    property alias styleColor : contentTextId.styleColor
    property alias textWidth: textWH.width
    property alias textHeight: textWH.height
    property alias m_textwh: textWH

    property bool m_bScrolling: false
    property bool m_bRepeat: true
    property real m_fSpeed: 0.05
    property color m_shadowColor:"transparent"
    property alias smooth : contentTextId.smooth
    property alias textFormat : contentTextId.textFormat
    property alias mouseEnabled : mousearea.enabled
    property alias mouseHoverEnable : mousearea.hoverEnabled
    property bool mouseAccepted : false
    property bool m_canScrolling : true

    signal linkActivated(string link)

    signal mouseEntered()
    signal mouseExited()

    onTextChanged: {
        contentTextId.text = text
        textWH.text = text
    }

    onM_bScrollingChanged:
    {
        if(m_bScrolling)
        {
            startpScroll()
        }
        else
        {
            stopScroll()
        }
    }

    Text {
        id: textWH
        visible: false
        font: contentTextId.font
        //text: _baseText.text
    }

    Text {
        id: contentTextId
        width: _baseText.width
        elide: Text.ElideRight
        x: horizontalAlignment == Text.AlignRight ? 0:0.5
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Microsoft YaHei"
        style: Text.Raised
        styleColor:m_shadowColor

        onLinkActivated: {
            _baseText.linkActivated(link)
        }

        NumberAnimation {
            id: animText
            target: contentTextId
            property: "x"
            duration: (contentTextId.contentWidth) / m_fSpeed
                      < 0 ? 0:(contentTextId.contentWidth) / m_fSpeed
            to: ( -contentTextId.contentWidth )

            onStopped: {
                contentTextId.x = horizontalAlignment == Text.AlignRight ? 0:0.5

                if (m_bRepeat && _baseText.visible && m_bScrolling){
                    contentTextId.x = _baseText.width
                    duration = ( contentTextId.contentWidth + _baseText.width )/m_fSpeed

                    if ( isNeedScroll() ){
                        animText.start()
                    }
                }
            }
        }
    }

    onVisibleChanged:
    {
        if(!visible)
        {
            m_bScrolling=false
        }
    }


    MouseArea
    {
        id:mousearea

        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        enabled: m_canScrolling
        onEntered:
        {
            m_bScrolling=true
        }
        onExited:
        {
            m_bScrolling=false
        }
        onPressed:
        {
            mouse.accepted = mouseAccepted;
        }
        onReleased:
        {
            if(Qt.platform != "android")
            {
                m_bScrolling=false
            }
        }
        onCanceled:
        {
            if(Qt.platform != "android")
            {
                m_bScrolling=false
            }
        }

    }

    Timer {
        id: _time
        interval: 1000

        onTriggered: {
            if ( isNeedScroll() )
            {
                animText.start()
            }
        }
    }

    function startpScroll ()
    {
        contentTextId.elide = Text.ElideNone

        if ( isNeedScroll() ){
            _time.start()
        }
    }

    function stopScroll ()
    {
        contentTextId.elide = Text.ElideNone
        _time.stop()
        animText.stop()
    }

    function isNeedScroll()
    {
        if ( textWH.contentWidth > _baseText.width )
            return true
        return false
    }
}
