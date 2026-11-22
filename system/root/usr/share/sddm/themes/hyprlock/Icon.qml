import QtQuick 2.15

Item {
    id: icon
    property string kind: "power"
    property color tint: "#afa193"
    property color hoverTint: "#f6f1ea"
    property bool hovered: area.containsMouse
    signal clicked()
    width: 22
    height: 22

    onHoveredChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.globalCompositeOperation = "source-over"
            ctx.clearRect(0, 0, width, height)
            var col = icon.hovered ? icon.hoverTint : icon.tint
            ctx.strokeStyle = col
            ctx.fillStyle = col
            ctx.lineWidth = 2
            var c = width / 2
            var r = 7
            ctx.beginPath()
            if (icon.kind === "power") {
                ctx.arc(c, c + 1, r, -Math.PI * 0.28, Math.PI * 1.28, false)
                ctx.stroke()
                ctx.beginPath()
                ctx.moveTo(c, 2)
                ctx.lineTo(c, c)
                ctx.stroke()
            } else if (icon.kind === "sleep") {
                ctx.arc(c, c, 8, 0, Math.PI * 2, false)
                ctx.fill()
                ctx.globalCompositeOperation = "destination-out"
                ctx.beginPath()
                ctx.arc(c + 5, c - 4, 7, 0, Math.PI * 2, false)
                ctx.fill()
                ctx.globalCompositeOperation = "source-over"
            } else {
                var a1 = Math.PI * 1.85
                ctx.arc(c, c, r, Math.PI * 0.2, a1, false)
                ctx.stroke()
                var ex = c + r * Math.cos(a1)
                var ey = c + r * Math.sin(a1)
                var tx = -Math.sin(a1)
                var ty = Math.cos(a1)
                var nx = Math.cos(a1)
                var ny = Math.sin(a1)
                ctx.beginPath()
                ctx.moveTo(ex + tx * 5, ey + ty * 5)
                ctx.lineTo(ex + nx * 4, ey + ny * 4)
                ctx.lineTo(ex - nx * 4, ey - ny * 4)
                ctx.closePath()
                ctx.fill()
            }
        }
        Component.onCompleted: requestPaint()
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: icon.clicked()
    }
}
