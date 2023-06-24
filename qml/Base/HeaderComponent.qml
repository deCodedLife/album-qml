import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../"

Rectangle {
    width: parent.width
    height: 64
    color: Header.color
    visible: Header.isVisible

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

                    onClicked: Loader.goBack()

                    width: 32
                    height: 32

                    Layout.alignment: Qt.AlignVCenter
                }

                ColumnLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        id: title
                        text: Header.title
                        color: Material.primaryTextColor
                        font.pointSize: Header.subtitle == "" ? Settings.h3 : Settings.h5
                    }

                    Text {
                        id: subtitle
                        visible: Header.subtitle != ""
                        text: Header.subtitle
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
                clip: true

                ListView {
                    id: optionsList
                    orientation: ListView.Horizontal
                    height: 32
                    width: 32 * model.length + ( Settings.minimalMargin * ( model.length - 1 ) )
                    spacing: Settings.minimalMargin

                    interactive: false
                    model: Header.options
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
                            Loader.openEffect()
                            modelData[ "action" ]()
                        }

                    }
                }
            }
        }
    }

    Component.onCompleted: actionButton.enabled = Loader.pagesDom.length > 1
}
