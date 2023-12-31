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

    signal finished

    x: AppLoader.lastMousePos.x - width / 2
    y: AppLoader.lastMousePos.y - height / 2

    NumberAnimation {
        target: rect
        id: animate
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 500
        to: Settings.root.height * 2
        onFinished: {
            AppLoader.popupCallback()
            rect.destroy()
        }
        running: true
    }
}
