import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "."
import "Base"

ApplicationWindow
{
    id: root

    width: 420
    height: Settings.is_mobile ? 780 : 730

    visible: true

    Material.theme: Settings.currentTheme
    Material.accent: Settings.currentAccent

    x: Settings.is_mobile ? 0 : Screen.width - 460
    y: Settings.is_mobile ? 0 : (Screen.height / 2) - (height / 2)

    background: Rectangle {
        anchors.fill: parent
        color: Material.backgroundColor
        radius: Settings.is_mobile ? 0 : 20
        clip: true
    }

    ColumnLayout {
        id: page
        anchors.fill: parent
        spacing: 0

        Header {
            Layout.fillWidth: true
            Component.onCompleted: Settings.headerTitle
        }

        Item {
            clip: true
            id: body

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.leftMargin:   Settings.is_mobile ? 0 : Settings.minimalMargin
            Layout.rightMargin:  Settings.is_mobile ? 0 : Settings.minimalMargin
            Layout.bottomMargin: Settings.is_mobile ? 0 : Settings.defaultmargin

            Flickable {
                contentWidth: body.width
                contentHeight: Settings.pageHeight

                width: body.width
                height: body.height


                Loader {
                    id: loader
                    width: body.width
                    height: body.height
                    source: Settings.currentPage
                }
            }
        }
    }

    MouseArea {
        id: appMouse
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }

    onClosing: {
        if( Settings.pagesDom.length > 1 ) {
            close.accepted = false
            Settings.goBack()
        }
    }

    Component.onCompleted: {
        contentItem.Keys.released.connect( function(event) {
            if (event.key === Qt.Key_Back) {
                event.accepted = true
                Settings.goBack()
            }
        })

        Settings.root = root
        Settings.appMosue = appMouse
        Settings.loadPage( "Pages/Stories.qml" )
    }
}
