import QtQuick
import QtQuick.Controls.Material

import ".."

Rectangle {
    id: rect
    width: 0
    height: 0
    color: Material.backgroundDimColor
    radius: width / 2
    z: 100

    x: Settings.lastMousePos.x
    y: Settings.lastMousePos.y

    NumberAnimation {
        target: rect
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 200
        to: Settings.root.height * 2
        onFinished: rect.destroy()
    }

    Component.onCompleted: animate.start()
}
