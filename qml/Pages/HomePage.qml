import QtQuick
import QtQuick.Controls.Material


import "../"
import "../Base"

AppPage {
    Text {
        anchors.centerIn: parent
        text: "Тут будут другие фишки, а пока - кликни на меня"
        font.pointSize: Settings.h4
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: AppLoader.openEffect( () => AppLoader.loadPage( "Pages/Stories.qml" ) )
    }

    onAfterInit: {
        AppHeader.hide()
    }
}
