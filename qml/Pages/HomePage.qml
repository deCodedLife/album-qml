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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Settings.popupCallback = () => Settings.loadPage( "Pages/Stories.qml" )
            Settings.openEffect()
        }
    }

    Component.onCompleted:
    {
        Settings.hideHeader()
    }
}
