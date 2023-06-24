import QtQuick
import QtQuick.Controls.Material

import "."
import ".."

ApplicationWindow
{
    id: root

    Material.theme: Settings.currentTheme
    Material.accent: Settings.currentAccent

    background: Rectangle {
        anchors.fill: parent
        color: Material.backgroundColor
        radius: Settings.is_mobile ? 0 : 20
        clip: true
    }

    visible: true

    Item {
        id: topItem
        width: parent.width
        height: parent.height

        Rectangle {
            id: background
            anchors.fill: parent
            color: "black"
            opacity: 0

            state: "normal"
            states: [
                State { name: "normal" },
                State {
                    name: "activated"
                    PropertyChanges {
                        target: background
                        opacity: 1
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation { target: background; properties: "opacity"; easing.type: Easing.InOutQuart; duration: 500 }
            }
        }

        onChildrenChanged: {
            if ( children.length > 1 ) background.state = "activated"
            else background.state = "normal"
        }

        function hide() { background.state = "nornal" }
    }


    Component.onCompleted: {
        contentItem.Keys.released.connect( function(event) {
            if (event.key === Qt.Key_Back) {
                event.accepted = true
                AppLoader.goBack()
            }
        })

        Settings.root = root
        Settings.imageLayout = topItem
        Settings.appMouse = appMouse
        AppLoader.loadPage( "Pages/Stories.qml" )
    }

    MouseArea {
        id: appMouse
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }

    onClosing: {
        if( Loader.pagesDom.length > 1 ) {
            close.accepted = false
            AppLoader.goBack()
        }
    }

}
