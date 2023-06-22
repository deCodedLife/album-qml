import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "."
import "Base"

ApplicationWindow
{
    width: 420
    height: 760

    visible: true

    Material.theme: Settings.currentTheme
    Material.accent: Settings.currentAccent

    x: Screen.width - 460
    y: (Screen.height / 2) - (height / 2)

    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Material.backgroundColor
        radius: 20
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Settings.defaultmargin
        spacing: 0

        Header {
            Layout.fillWidth: true
            Component.onCompleted: Settings.headerTitle
        }

        Loader {
            id: loader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: Settings.currentPage
        }
    }

    Component.onCompleted: Settings.loadPage( "Pages/Stories.qml" )
}
