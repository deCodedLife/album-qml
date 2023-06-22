import QtQuick
import QtQuick.Controls.Material

Rectangle {
    width: 0
    height: width
    color: Material.backgroundDimColor
    radius: width / 2
    z: 100

    property int value: 0

    NumberAnimation {
        properties: "width,height"
        easing.type: Easing.InOutQuart
        duration: 200
        to: value * 2
        running: true
        loops: 0
    }

    Component.onCompleted: console.log( "test" )
}
