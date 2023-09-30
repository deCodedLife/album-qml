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
    source: ""
    z: -1

    onStatusChanged: (status) => {
         if ( status === Image.Ready ) destroyer.start()
    }

    Timer {
        id: destroyer
        interval: 1800
        repeat: false
        onTriggered: firework.destroy()
    }

    Timer {
        interval: Math.random() * 1000
        repeat: false
        running: true
        onTriggered: firework.source = [SERVER, QML, "Images/fireworks.gif"].join("/")
    }
}
