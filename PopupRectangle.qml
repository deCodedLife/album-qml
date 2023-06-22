import QtQuick
import QtQuick.Controls.Material

Rectangle {
    x: 0
    y: 0
    id: rect
    width: 500
    height: 500
    color: Material.backgroundDimColor
    radius: width / 2
    z: 100

    property int value: 5000

    NumberAnimation {
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 200
        to: value * 2
        running: true
        loops: 0
        onFinished: rect.destroy()
    }

    Component.onCompleted: animate.start()
}
