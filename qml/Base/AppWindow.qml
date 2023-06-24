import QtQuick
import QtQuick.Layouts
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

    ColumnLayout {
        anchors.fill: parent

        HeaderComponent {
            Layout.fillWidth: true
        }

        PageLoader {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

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
        Component.onCompleted: AppLoader.imageLayout = topItem

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
        AppLoader.root = root
    }

    onClosing: {
        if( Loader.pagesDom.length > 1 ) {
            close.accepted = false
            AppLoader.goBack()
        }
    }

    MouseArea {
        id: appMouse
        anchors.fill: parent
        onPressed: mouse.accepted = false
        Component.onCompleted: {
            Settings.appMouse = appMouse
            AppLoader.appMouse = appMouse
        }
    }

}
