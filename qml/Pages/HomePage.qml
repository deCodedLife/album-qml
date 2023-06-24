import QtQuick


import "../"
import "../Base"

AppPage {
    Text {
        anchors.centerIn: parent
        text: "Hello world"
        font.pointSize: Settings.h4
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: AppLoader.openEffect( () => AppLoader.loadPage( "Pages/Stories.qml" ) )
    }

    onAfterInit: AppHeader.hide()
}
