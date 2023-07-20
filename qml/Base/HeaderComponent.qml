import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "."
import ".."

Rectangle {
    width: parent.width
    height: 64
    color: AppHeader.color
    visible: AppHeader.isVisible

    Item {
        id: header
        anchors.fill: parent
        anchors.leftMargin: Settings.defaultmargin + Settings.minimalMargin
        anchors.rightMargin: Settings.defaultmargin + Settings.minimalMargin

        RowLayout{
            anchors.fill: parent

            anchors.topMargin: Settings.defaultmargin
            anchors.bottomMargin: Settings.defaultmargin
            Layout.alignment: Qt.AlignVCenter


            RowLayout {
                spacing: Settings.defaultmargin
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                clip: true

                Button {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32

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

                    onClicked: AppLoader.goBack()

                    width: 32
                    height: 32

                    Layout.alignment: Qt.AlignVCenter
                }

                ColumnLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 0
                    clip: true

                    Text {
                        id: title
                        text: AppHeader.title
                        color: Material.primaryTextColor
                        font.pointSize: AppHeader.subtitle == "" ? Settings.h4 : Settings.h6
                    }

                    Text {
                        id: subtitle
                        visible: AppHeader.subtitle != ""
                        text: AppHeader.subtitle
                        color: Material.primaryTextColor
                        opacity: 0.7
                        font.pointSize: Settings.h7
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                Layout.alignment: Qt.AlignLeft

                ListView {
                    id: optionsList
                    orientation: ListView.Horizontal
                    layoutDirection: Qt.RightToLeft
                    Layout.fillWidth: true
                    height: 32
                    spacing: Settings.minimalMargin

                    interactive: false
                    model: AppHeader.options

                    delegate: Button {
                        icon.source: [SERVER, QML, "Images", modelData[ "icon" ]].join("/")
                        icon.color: Material.primaryTextColor
                        icon.width: 32
                        icon.height: 32
                        flat: true
                        width: 32
                        height: 32
                        padding: 0
                        topInset: 0
                        bottomInset: 0
                        verticalPadding: 0
                        leftPadding: 0
                        rightPadding: 0
                        onClicked: {
                            icon.color = Material.accentColor
                            AppLoader.openEffect( modelData[ "action" ] )
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: actionButton.enabled = AppLoader.pagesDom.length > 1
}
