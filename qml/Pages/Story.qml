import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

Item {
    property var storyData: Settings.pageContent

    id: page
    width: parent.width
    height: implicitHeight

    ColumnLayout {
        id: body
        anchors.fill: parent
        anchors.leftMargin: Settings.defaultmargin
        anchors.rightMargin: Settings.defaultmargin
        spacing: Settings.defaultmargin

        onImplicitHeightChanged: parent.height = implicitHeight

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

        Text {
            text: "Описание"
            font.pointSize: Settings.h3
            font.bold: true
            color: Material.primaryTextColor
        }

        TextArea {
            Layout.fillWidth: true
            height: 250
            text: storyData[ "comment" ]
        }

        Rectangle{ Layout.fillHeight: true }
    }

    Component.onCompleted:
    {
        Settings.headerTitle = storyData[ "timestamp" ].split(" ")[ 0 ]
        Settings.headerSubtitle = storyData[ "timestamp" ].split(" ")[ 1 ]
        Settings.showHeader()
    }
}
