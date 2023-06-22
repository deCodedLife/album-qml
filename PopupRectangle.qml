import QtQuick
import QtQuick.Controls.Material

Rectangle {
    id: rect
    width: 0
    height: 0
    color: Material.backgroundDimColor
    radius: width / 2
    z: 100

    property int value: 0

    NumberAnimation {
        target: rect
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 200
        to: value * 2
        onFinished: rect.destroy()
    }

    Component.onCompleted: animate.start()
}
