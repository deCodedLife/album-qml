import QtQuick
import "../"

Timer {
    id: timer
    property Component fireworkImage: Qt.createComponent( "Firework.qml" )
    running: AppLoader.currentPage === "Pages/Birthday.qml"
    interval: Math.random() * 1000
    repeat: true

    onTriggered: {
        fireworkImage.createObject( Settings.root )
    }
}
