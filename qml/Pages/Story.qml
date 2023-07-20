import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage {
    property var storyData: AppLoader.pageContent
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

        Flickable {
             id: flick

             Layout.fillWidth: true
             height: 200;
             contentWidth: edit.contentWidth
             contentHeight: edit.contentHeight
             clip: true

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

             TextArea {
                 width: flick.width
                 height: flick.height
                 implicitHeight: flick.height
                 wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
                 placeholderText: getRandomText()
                 text: storyData[ "comment" ]
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             }

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
        AppLoader.reloadFlickable()
    }
}
