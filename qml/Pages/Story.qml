import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage {
    property var storyData: Loader.pageContent
    height: body.implicitHeight
    id: page

    ColumnLayout {
        id: body
        anchors.fill: parent
        anchors.topMargin: Settings.defaultmargin
        anchors.leftMargin: Settings.defaultmargin
        anchors.rightMargin: Settings.defaultmargin
        spacing: Settings.defaultmargin

        Text {
            text: "Фотографии"
            color: Material.primaryTextColor
            font.pointSize: Settings.h3
            font.bold: true
        }

        CarouselComponent {
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

    onAfterInit:
    {
        AppHeader.color = "transparent"
        AppHeader.title = storyData[ "timestamp" ].split(" ")[ 0 ]
        AppHeader.subtitle = storyData[ "timestamp" ].split(" ")[ 1 ]
    }
}
