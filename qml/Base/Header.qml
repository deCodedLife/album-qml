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

                    onClicked: Settings.goBack()

                    width: 32
                    height: 32

                    Layout.alignment: Qt.AlignVCenter
                }

                ColumnLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        id: title
                        text: Settings.headerTitle
                        color: Material.primaryTextColor
                        font.pointSize: Settings.headerSubtitle == "" ? Settings.h3 : Settings.h5
                    }

                    Text {
                        id: subtitle
                        enabled: Settings.headerSubtitle != ""
                        visible: enabled
                        text: Settings.headerSubtitle
                        color: Material.primaryTextColor
                        opacity: 0.7
                        font.pointSize: Settings.h6
                    }
                }
            }

            Rectangle { Layout.fillWidth: true }

            RowLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: optionsList.width

                ListView {
                    id: optionsList
                    orientation: ListView.Horizontal
                    Layout.fillHeight: true
                    width: 32 * model.length

                    interactive: false
                    model: Settings.headerOptions == [] ? [ "add.svg", "play.svg" ] : Settings.headerOptions
                    delegate: Button {
                        icon.source: [SERVER, QML, "Images", modelData[ "icon" ]].join("/")
                        icon.color: Material.primaryTextColor
                        icon.width: 48
                        icon.height: 48
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
                            Settings.openEffect()
                            modelData[ "action" ]()
                        }

                    }

                    Connections {
                        target: Settings
                        function onOptionsUpdated( options ) { optionsList.model = options; console.log( JSON.stringify( options ) ) }
                    }
                }
            }
        }
    }

    Component.onCompleted: actionButton.enabled = Settings.pagesDom.length > 1
}
