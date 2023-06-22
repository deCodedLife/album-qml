import QtQuick


import "../"
import "../Base"

Item {
    anchors.fill: parent
    clip: true

    Text {
        anchors.centerIn: parent
        text: "Hello world"
        font.pointSize: Settings.h4
        color: "white"
    }

    Component.onCompleted:
    {
        Settings.hideHeader()
    }
}
