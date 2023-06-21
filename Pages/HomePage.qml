import QtQuick


import "../"
import "../Base"

Item {
    anchors.fill: parent

    MapComponent {
        anchors.fill: parent
    }

    Component.onCompleted:
    {
        Settings.hideHeader()
    }
}
