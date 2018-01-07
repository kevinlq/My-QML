import QtQuick 2.0

Item {
    //鱼头半径
    property var m_headRadius: 50
    //第一节身体长度
    property var m_bodyLength: m_headRadius* 3.2
    property var m_bodyAlpha: 220
    property var m_otherAlpha: 160
    property var m_finsAlpha: 100
    //左右鱼鳍
    property var m_finsLeft: 1
    property var m_finsRight: -1
    property var m_finsLength: m_headRadius * 1.3

    //鱼长度
    property var m_fishLength: m_headRadius * 1.3
    property var m_totalLength: 6.79 * m_headRadius

    property var m_mainAngle: 90
    property var m_currentValue: 0
    //全局摆动频率
    property var m_waveFrequence: 1

    //鱼头点
    property var m_headPoint
    //转弯更自然的中心点
    property var m_middlePoint
    //鱼鳍角度
    property var m_finsAngle: 0

    anchors.centerIn: parent

    Component.onCompleted:
    {
        init();

        console.log("init finished")
        console.log("m_otherAlpha:"+m_otherAlpha);
        console.log("m_finsAlpha:"+m_finsAlpha);
        console.log("m_bodyAlpha:"+m_bodyAlpha);
    }
    //初始化操作
    function init(){
        m_bodyAlpha/=255.0;
        m_otherAlpha/=255.0
        m_finsAlpha/=255.0

        m_middlePoint = [4.18*m_headRadius,4.18*m_headRadius];
    }

    function updateCanvas(){
        canvas.requestPaint();
    }

    function setCurrentValue(value){
        m_currentValue = value;
    }

    function setFinsAlgle (angleValue){
        m_currentValue = 45 + angleValue;
    }

    function setWaveFrequence (waveFrequence){
        m_waveFrequence = waveFrequence;
    }

    /*固有宽高就是可以容纳小鱼360旋转的最小尺寸*/
    //获取固有宽度
    function getIntrinsicWidth(){
        return parseInt(8.38 * m_headRadius);
    }
    //获取固有高度
    function getIntrinsicHeight(){
        return parseInt(8.38 * m_headRadius);
    }

    Canvas{
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            //set m_otherAlpha
            ctx.fillStyle = 'rgba(244, 92, 71, 0.6)';
            drawBody(ctx,m_headRadius);

            //set m_otherAlpha
            ctx.fillStyle = 'rgba(244, 92, 71, 0.61)';
        }

        function drawBody(ctx,headRadius){
            //现有角度=原始角度+ sin(阈值[-1,1]) * 可摆动的角度
            var angle = m_mainAngle + Math.sin(
                        getRadians( m_currentValue * 1.2 * m_waveFrequence)) * 2;

            //计算头部圆心坐标
            m_headPoint = calculatPoint(m_middlePoint[0], m_middlePoint[1],
                                        m_bodyLength/2,m_mainAngle);
            //画鱼头
            ctx.beginPath();
            ctx.arc(m_headPoint[0],m_headPoint[1],m_headRadius,0,Math.PI * 2,true);
            ctx.fill();
            //ctx.stroke();

            //鱼右鳍起点
            var arFinsRight = calculatPoint(m_headPoint[0],m_headPoint[1],
                                            m_headRadius * 0.9, angle - 110);
            drawFins(ctx,arFinsRight,m_finsRight,angle);

            //鱼左鳍起点
            var arFinsLeft = calculatPoint(m_headPoint[0],m_headPoint[1],
                                           m_headRadius * 0.9, angle + 110);
            drawFins(ctx,arFinsLeft,m_finsLeft,angle);

            var arEndPoint = calculatPoint(m_headPoint[0],m_headPoint[1],
                                           m_bodyLength, angle - 180);

            var arPoint1,arPoint2,arPoint3,arPoint4,arContralLeft,arContralRight;
            //point1和4的初始角度决定发髻线的高低,值越大越低
            arPoint1 = calculatPoint( m_headPoint[0],m_headPoint[1],
                                     m_headRadius, angle - 80);
            arPoint2 = calculatPoint( arEndPoint[0],arEndPoint[1],
                                     m_headRadius * 0.7, angle - 90);
            arPoint3 = calculatPoint( arEndPoint[0], arEndPoint[1],
                                     m_headRadius * 0.7, angle + 90);
            arPoint4 = calculatPoint( m_headPoint[0], m_headPoint[1],
                                     m_headRadius, angle + 80);
            //决定胖瘦
            arContralLeft = calculatPoint( m_headPoint[0], m_headPoint[1],
                                          m_bodyLength * 0.56, angle - 130);
            arContralRight = calculatPoint( m_headPoint[0], m_headPoint[1],
                                           m_bodyLength * 0.56, angle + 130);
            ctx.beginPath();
            ctx.moveTo( arPoint1[0],arPoint1[1]);
            ctx.quadraticCurveTo(arContralLeft[0], arContralLeft[1],
                                 arPoint2[0], arPoint2[1]);
            ctx.lineTo(arPoint3[0], arPoint3[1]);

            ctx.quadraticCurveTo( arContralRight[0],arContralRight[1],
                                 arPoint4[0], arPoint4[1]);

            ctx.lineTo( arPoint1[0], arPoint1[1]);

            //填充最大身子
            ctx.fillStyle = 'rgba(244,92,71,0.8)';
            ctx.fill();

            //躯干2
            var arMainPoint = arEndPoint;
            drawSegments(ctx,arMainPoint,m_headRadius*0.7,0.6,angle );
        }

        /*
                输入起点坐标、线的长度、旋转角度，计算终点坐标
                注:sin和cos参数是弧度制，这里将传入的角度转换为了弧度getRadians()
            */
        function calculatPoint (startPointX,startPointY,length,angle){
            //判断参数是浮点型....
            var deltaX = Math.cos( getRadians(angle)) * length;
            //下面angle-180是为了将y轴坐标朝下
            var deltaY = Math.sin( getRadians(angle - 180 )) * length;
            var array = [startPointX + deltaX, startPointY + deltaY];
            return array;
        }

        /*弧度和角度转换计算*/
        //根据角度计算弧度
        function getRadians (angle){
            return (angle *Math.PI /180);
        }
        //根据弧度计算角度
        function getAngle (radians){
            return ( radians * 180 / Math.PI);
        }

        /**
               绘制鱼鳍
               ctx:
               arrayStartPoint:起点坐标
            */
        function drawFins(ctx,arrayStartPoint,type,fatherAngle){
            //鱼鳍三角控制角度
            var contralAngle = 115;
            var angle,endPoint,contralPoint;
            //分别计算鱼鳍左右点坐标以及控制坐标
            if ( type == m_finsLeft){
                angle = fatherAngle + m_finsAngle + 180;
                endPoint = calculatPoint(arrayStartPoint[0],arrayStartPoint[1],
                                         m_finsLength,angle);
                angle =fatherAngle + contralAngle + m_finsAngle;
                contralPoint = calculatPoint(arrayStartPoint[0],arrayStartPoint[1],
                                             m_finsLength*1.8,angle);
            }
            else if (type == m_finsRight)
            {
                angle = fatherAngle - 180;
                endPoint = calculatPoint(arrayStartPoint[0],arrayStartPoint[1],
                                         m_finsLength,angle);
                angle = fatherAngle - contralAngle - m_finsAngle;
                contralPoint = calculatPoint(arrayStartPoint[0],arrayStartPoint[1],
                                             m_finsLength*1.8,angle);
            }

            ctx.beginPath();
            ctx.moveTo(arrayStartPoint[0],arrayStartPoint[1]);

            //绘制贝塞尔曲线
            //set m_finsAlpha
            ctx.fillStyle = 'rgba(244,92,71,0.3)';
            ctx.quadraticCurveTo(contralPoint[0],contralPoint[1],endPoint[0],endPoint[1]);
            ctx.lineTo(arrayStartPoint[0],arrayStartPoint[1]);
            ctx.fill();
            //ctx.stroke();
            //set m_otherAlpha
            //ctx.fillStyle = 'rgba(244,92,71,0.6)';
        }

        /*
              绘制第二节肢
              mp:梯度上边下边长度比
            */
        function drawSegments (ctx,arrayMainPoint,segmentRadius,mp,fatherAngle){
            var angle = fatherAngle + Math.cos(
                        getRadians( m_currentValue * 1.5 * m_waveFrequence))*15;
            //身长
            var segmentLength = segmentRadius * (mp + 1);
            var arEndPoint = calculatPoint(arrayMainPoint[0],arrayMainPoint[1],
                                           segmentLength, angle - 180);

            var arPoint1,arPoint2,arPoint3,arPoint4;
            arPoint1 = calculatPoint(arrayMainPoint[0],arrayMainPoint[1],
                                     segmentRadius, angle - 90);
            arPoint2 = calculatPoint(arEndPoint[0],arEndPoint[1],
                                     segmentRadius * mp, angle - 90);
            arPoint3 = calculatPoint(arEndPoint[0],arEndPoint[1],
                                     segmentRadius * mp, angle + 90);
            arPoint4 = calculatPoint(arrayMainPoint[0],arrayMainPoint[1],
                                     segmentRadius, angle + 90);
            //画曲线
            ctx.beginPath();
            ctx.arc( arrayMainPoint[0],arrayMainPoint[1],segmentRadius,0,Math.PI*2);
            ctx.fill();

            ctx.beginPath();
            //目前有个问题，这个圆上半部分被挡住了
            ctx.arc( arEndPoint[0],arEndPoint[1],segmentRadius * mp,0,Math.PI*2);
            ctx.fill();

            ctx.moveTo( arPoint1[0],arPoint1[1]);
            ctx.lineTo( arPoint2[0],arPoint2[1]);
            ctx.lineTo( arPoint3[0],arPoint3[1]);
            ctx.lineTo( arPoint4[0],arPoint4[1]);
            ctx.fill();

            ctx.beginPath();
            ctx.arc( arEndPoint[0],arEndPoint[1],segmentRadius * mp,0,Math.PI*2);
            ctx.fill();

            //躯干2
            var arMainpoint2 = arEndPoint;
            drawSegmentsLong(ctx,arMainpoint2,segmentRadius *0.6, 0.4, angle);
        }

        function drawSegmentsLong(ctx,arMainPoint,segmentRadius,mp,fatherAngle){
            var angle = fatherAngle + Math.sin(
                        getRadians(m_currentValue * 1.5 * m_waveFrequence)) * 35;
            //身长
            var segmentLength = segmentRadius *(mp * 2.7);
            var arEndPoint = calculatPoint(arMainPoint[0],arMainPoint[1],
                                           segmentLength, angle - 180);

            var arPoint1,arPoint2,arPoint3,arPoint4;
            arPoint1 = calculatPoint(arMainPoint[0],arMainPoint[1],
                                     segmentRadius, angle - 90);
            arPoint2 = calculatPoint(arEndPoint[0],arEndPoint[1],
                                     segmentRadius * mp, angle - 90);
            arPoint3 = calculatPoint(arEndPoint[0],arEndPoint[1],
                                     segmentRadius * mp, angle + 90);
            arPoint4 = calculatPoint(arMainPoint[0],arMainPoint[1],
                                     segmentRadius, angle + 90);

            drawTail(ctx,arMainPoint,segmentLength,segmentRadius,angle);

            //画曲线
            ctx.beginPath();
            ctx.arc( arEndPoint[0],arEndPoint[1],segmentRadius * mp,0,Math.PI*2);
            ctx.fill();

            ctx.beginPath();
            ctx.moveTo( arPoint1[0],arPoint1[1]);
            ctx.lineTo( arPoint2[0],arPoint2[1]);
            ctx.lineTo( arPoint3[0],arPoint3[1]);
            ctx.lineTo( arPoint4[0],arPoint4[1]);
            ctx.fill();
        }

        /*
              鱼尾及鱼尾张合
            */
        function drawTail (ctx,arMainPoint,length,maxWith,angle){
            var curAngle = m_currentValue * 1.7 * m_waveFrequence;
            var arNewWidth = Math.abs(
                        Math.sin( getRadians(curAngle))*maxWith + m_headRadius/5*3);
            //endPoint为三角形底边中点
            var arEndPoint = calculatPoint( arMainPoint[0], arMainPoint[1],
                                           length, angle - 180);
            var arEndPoint2 = calculatPoint( arMainPoint[0], arMainPoint[1],
                                            length - 10, angle - 180);
            var arPoint1,arPoint2,arPoint3,arPoint4;
            arPoint1 = calculatPoint(arEndPoint[0],arEndPoint[1],arNewWidth,angle - 90);
            arPoint2 = calculatPoint(arEndPoint[0],arEndPoint[1],arNewWidth,angle + 90);
            arPoint3 = calculatPoint(arEndPoint2[0],arEndPoint2[1],arNewWidth - 20,angle - 90);
            arPoint4 = calculatPoint(arEndPoint2[0],arEndPoint2[1],arNewWidth - 20,angle + 90);
            //内
            ctx.beginPath();
            ctx.moveTo(arMainPoint[0], arMainPoint[1]);
            ctx.lineTo( arPoint3[0], arPoint3[1]);
            ctx.lineTo( arPoint4[0], arPoint4[1]);
            ctx.moveTo(arMainPoint[0], arMainPoint[1]);
            ctx.fill();

            //外
            ctx.moveTo(arMainPoint[0], arMainPoint[1]);
            ctx.lineTo( arPoint1[0], arPoint1[1]);
            ctx.lineTo( arPoint2[0], arPoint2[1]);
            ctx.moveTo(arMainPoint[0], arMainPoint[1]);
            ctx.fill();
        }
    }
}
