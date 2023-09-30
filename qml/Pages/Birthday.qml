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
    property bool isActive: false

    Timer {
        id: fireworksGenerator
        interval: 1800
        running: false
        repeat: true
        onTriggered: {
            for ( let i = 0; i < 20; i++ ) fireworkImage.createObject( page )
        }
    }

    function produceFireworks() {
        if ( isActive ) {
            AppLoader.openEffect( () => AppLoader.goBack() )
            return
        }
        isActive = true
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
            source: [SERVER, QML, "Images/present.png"].join("/") // SERVER

            onStatusChanged: (status) => {
                 if ( status === Image.Ready ) {
                     imageShowUP.start()
                     textShouUP.start()
                 }
            }

            NumberAnimation on y {
                id: imageShowUP
                running: false
                to: (Settings.root.height / 2) - (gift.height)
                duration: 2000
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
            y: page.height - text.contentHeight * 2 - Settings.minimalMargin

            text: "С днём рождения, зая)"
            font.pixelSize: Settings.h1
            font.bold: true
            opacity: 0

            NumberAnimation on opacity {
                id: textShouUP
                running: false
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
