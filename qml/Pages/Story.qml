import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage {
    property var storyData: AppLoader.pageContent
    height: body.implicitHeight + 250
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
            implicitHeight: 250
            wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
            placeholderText: getRandomText()
            text: storyData[ "comment" ]
        }

        Rectangle{ Layout.fillHeight: true }
    }

    function getRandomText() {
        let randomPhrase = [
            "Какие у тебя были эмоции?",
            "Как это развидеть?",
            "Какие-нибудь детали?",
            "*ТУТ БЫЛ КОНТЕКСТ*",
        ]
        return randomPhrase[ Math.floor( Math.random() * randomPhrase.length ) ]
    }

    onAfterInit:
    {
        AppHeader.color = "transparent"
        AppHeader.title = storyData[ "timestamp" ].split(" ")[ 0 ]
        AppHeader.subtitle = storyData[ "timestamp" ].split(" ")[ 1 ]
    }
}
