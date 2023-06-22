import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."

Item {
    anchors.fill: parent
    property var storyData: Settings.pageContent

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: "Фотографии"
            color: Material.primaryTextColor
            font.pointSize: Settings.h5
        }

        Rectangle{ Layout.fillHeight: true }
    }

    Component.onCompleted:
    {
        Settings.headerTitle = ""
        Settings.showHeader()
    }
}
