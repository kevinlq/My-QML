import QtQuick 2.0

Item {
    property bool flag: false
    Canvas{
        id: vanvas
        width: 600
        height: 600

        onPaint: {
            var ctx = getContext("2d")
            //set m_otherAlpha
            ctx.fillStyle = 'rgba(244, 92, 71, 0.6)';
            ctx.arc(60,100,50,0,-Math.PI / 2,flag);
            ctx.closePath();
            ctx.stroke();

            ctx.beginPath();
            ctx.fillStyle = 'rgba(244, 92, 71, 0.3)';
            ctx.arc(170,100,50,0,Math.PI ,flag);
            ctx.stroke();

            ctx.beginPath();
            ctx.fillStyle = 'rgba(244, 92, 71, 0.3)';
            ctx.arc(280,100,50,0,Math.PI*3/2 ,flag);
            ctx.stroke();

            ctx.beginPath();
            ctx.fillStyle = 'rgba(244, 92, 71, 0.3)';
            ctx.arc(390,100,50,0,Math.PI*2 ,flag);
            ctx.stroke();

            //set m_otherAlpha
            //            ctx.fillStyle = 'rgba(244, 92, 71, 0.61)';
        }
    }
}
