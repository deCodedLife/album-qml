import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

Item {
    anchors.fill: parent
    property var storyData: Settings.pageContent

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: "Фотографии"
            color: Material.primaryTextColor
            font.pointSize: Settings.h4
            font.bold: true
        }

        Carousel {
            images: storyData[ "file" ]
            Layout.fillWidth: true
            height: 400
        }

        Rectangle{ Layout.fillHeight: true }
    }

    Component.onCompleted:
    {
        Settings.headerTitle = ""
        Settings.showHeader()
    }
}
