import QtQuick
import QtQuick.Controls.Material

import ".."

Rectangle
{
    id: rect
    width: 0
    height: 0
    color: Material.backgroundColor
    radius: width / 2
    z: 10

    x: Loader.lastMousePos.x - width / 2
    y: Loader.lastMousePos.y - height / 2

    NumberAnimation {
        target: rect
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 500
        to: Settings.root.height * 2
        onFinished: {
            Loader.popupEnded()
            rect.destroy()
        }
        Component.onCompleted: start()
    }
}
