import QtQuick
import "../"

Timer {
    id: timer
    property Component fireworkImage: Qt.createComponent( "Firework.qml" )
    running: AppLoader.currentPage === "Pages/Birthday.qml"
    interval: Math.random() * 1000
    repeat: false

    onTriggered: {
        if ( AppLoader.currentPage !== "Pages/Birthday.qml" ) return
        fireworkImage.createObject( Settings.root )
        delete timer
    }
}
