import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../"
import "../Base"

AppPage
{
    id: page
    clip: true

    property Component fireworks: Qt.createComponent( "../Base/FireworkService.qml" )
    property Component fireworkImage: Qt.createComponent( "../Base/Firework.qml" )

    Timer {
        id: fireworksGenerator
        interval: 2000
        running: false
        repeat: true
        onTriggered: {
            for ( let i = 0; i < 20; i++ ) fireworks.createObject( Settings.root )
        }
    }

    function produceFireworks() {
        if ( fireworksGenerator.running ) {
            AppLoader.openEffect( () => AppLoader.goBack() )
            return
        }

        for ( let i = 0; i < 20; i++ ) fireworkImage.createObject( Settings.root )
        fireworksGenerator.start()
    }

    Rectangle {
        id: frame
        color: "transparent"

        Image {
            id: gift
            x: page.width / 2 - ( gift.width / 2 )
            y: Settings.root.height
            width: 215
            height: 200
            sourceSize: Qt.size( 215, 200 )
            source: [ "http://localhost" , QML, "Images/present.png"].join("/") // SERVER

            NumberAnimation on y {
                to: (Settings.root.height / 2) - (gift.height)
                duration: 1200
                easing.type: Easing.InOutQuart
                onFinished: gift.y = (Settings.root.height / 2) - (gift.height)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: produceFireworks()
            }
        }

        Text {
            id: text

            x: page.width / 2 - text.contentWidth / 2
            y: page.height - text.contentHeight - Settings.minimalMargin

            text: "С днём рождения, зая)"
            font.pixelSize: Settings.h1
            font.bold: true
            opacity: 0

            NumberAnimation on opacity {
                to: 1
                duration: 1700
                onFinished: text.opacity = 1
            }
        }
    }


    onAfterInit: {
        Settings.currentTheme = Material.Light
        AppHeader.hide()
        AppHeader.color = Material.backgroundColor
    }
}
