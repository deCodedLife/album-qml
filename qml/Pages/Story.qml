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
        anchors.leftMargin: Settings.defaultmargin
        anchors.rightMargin: Settings.defaultmargin
        spacing: Settings.defaultmargin

        Text {
            text: "Фотографии"
            color: Material.primaryTextColor
            font.pointSize: Settings.h3
            font.bold: true
        }

        Carousel {
            images: storyData[ "file" ]
            Layout.fillWidth: true
            itemHeight: 450
        }

        Rectangle{ Layout.fillHeight: true }
    }

    Component.onCompleted:
    {
        Settings.headerTitle = ""
        Settings.showHeader()
        console.log( JSON.stringify(storyData) )
    }
}
