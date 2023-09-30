import QtQuick

import "../"
import "."

AnimatedImage {
    id: firework

    property int maxWidth: Settings.root.width * 2 + 1
    property int maxHeight: Settings.root.height * 2 + 1

    x: Math.floor( Math.random() * maxWidth - firework.width )
    y: Math.floor( Math.random() * maxHeight - firework.height )

    width: 400
    height: 400
    source: ["http://localhost", QML, "Images/fireworks.gif"].join("/")
    z: -1
    enabled: AppLoader.currentPage === "Pages/Birthday.qml"
    visible: AppLoader.currentPage === "Pages/Birthday.qml"

    Timer {
        id: destroyer
        interval: 1800
        repeat: false
        onTriggered: {
            firework.destroy()
            firework.source = ""
            delete firework
        }
    }

    Component.onCompleted: {
        console.log( AppLoader.currentPage )
        if ( AppLoader.currentPage != "Pages/Birthday.qml" ) {
            firework.destroy()
            delete firework
        }
        destroyer.start()
    }
}
