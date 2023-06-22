import QtQuick


import "../"
import "../Base"

Item {
    anchors.fill: parent
    clip: true

    MapComponent {
        anchors.fill: parent
    }

    Component.onCompleted:
    {
        Settings.hideHeader()
    }
}
