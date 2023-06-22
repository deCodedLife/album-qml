import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../"

Rectangle {
    width: parent.width
    height: 64
    color: Settings.headerColor
    visible: Settings.isHeaderVisible

    Item {
        id: header
        anchors.fill: parent
        anchors.leftMargin: Settings.minimalMargin
        anchors.rightMargin: Settings.minimalMargin

        RowLayout{
            anchors.fill: parent
            spacing: Settings.minimalMargin

            Button {
                id: actionButton
                icon.source: [SERVER, QML, "Images/back.svg"].join("/")
                icon.color: Material.primaryTextColor
                icon.width: 24
                icon.height: 24
                flat: true
                padding: 0
                topInset: 0
                bottomInset: 0
                verticalPadding: 0
                leftPadding: 0
                rightPadding: 0
                onClicked: Settings.goBack()
                Layout.alignment: Qt.AlignVCenter
            }

            ColumnLayout{
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    id: title
//                    Layout.alignment: Settings.headerSubtitle == "" ? Qt.AlignVCenter : Qt.AlignTop
                    Layout.bottomMargin: Settings.headerSubtitle == "" ? Settings.minimalMargin : 0
                    text: Settings.headerTitle
                    color: Material.primaryTextColor
                    font.pointSize: Settings.h3
                }

                Text {
                    id: subtitle
                    enabled: Settings.headerSubtitle != ""
                    visible: enabled
                    text: Settings.headerSubtitle
                    color: Material.primaryTextColor
                    opacity: 0.7
                    font.pointSize: Settings.h5
                }
            }

            Rectangle { Layout.fillWidth: true }
        }
    }

    Component.onCompleted: actionButton.enabled = Settings.pagesDom.length > 1
}
