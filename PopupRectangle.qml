import QtQuick
import QtQuick.Controls.Material

import ".."

Rectangle {
    id: rect
    width: 0
    height: 0
    color: "white"
    radius: width / 2
    z: 100

    x: Settings.lastMousePos.x - width / 2
    y: Settings.lastMousePos.y - height / 2

    NumberAnimation {
        target: rect
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 500
        to: Settings.root.height * 2
        onFinished: rect.destroy()
    }

    Component.onCompleted: animate.start()
}
