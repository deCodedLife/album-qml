import QtQuick
import QtQuick.Layouts

import ".."

Item {
    anchors.fill: parent
    property var storyData: Settings.pageContent

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: "Фотографии"
            font.pointSize: Settings.h5
        }
    }

    Component.onCompleted:
    {
        Settings.headerTitle = ""
        Settings.showHeader()
    }
}
