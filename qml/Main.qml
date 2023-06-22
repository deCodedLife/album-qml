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
        anchors.fill: parent
        spacing: 0

        Header {
            Layout.fillWidth: true
            Component.onCompleted: Settings.headerTitle
        }

        Flickable {
            contentWidth: root.width
            contentHeight: loader.implicitHeight
            flickableDirection: Qt.Vertical

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: Settings.is_mobile ? 0 : Settings.minimalMargin
            Layout.rightMargin:  Settings.is_mobile ? 0 : Settings.minimalMargin
            Layout.bottomMargin:  Settings.is_mobile ? 0 : Settings.defaultmargin

            Loader {
                id: loader
                anchors.fill: parent
                source: Settings.currentPage
            }
        }
    }

    MouseArea {
        id: appMouse
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }

    Component.onCompleted: {
        Settings.root = root
        Settings.appMosue = appMouse
        Settings.loadPage( "Pages/Stories.qml" )
    }
}
