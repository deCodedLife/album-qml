import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import ".."
import "../Base"

AppPage
{
    id: page

    ColumnLayout {
        id: body
        anchors.fill: parent
        anchors.topMargin: Settings.defaultmargin
        anchors.leftMargin: Settings.defaultmargin
        anchors.rightMargin: Settings.defaultmargin

        GridView {
            id: grid
            Layout.fillWidth: true
            height: parent.height
            cellWidth: parent.width / 2
            cellHeight: parent.width / 2

            model: Settings.storiesList
            delegate: Item {
                id: storyItem
                property var storyData: modelData

                height: grid.width / 2
                width: grid.width / 2

                Image {
                    id: image
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.centerIn: parent
                    sourceSize.height: parent.height - Settings.minimalMargin
                    anchors.margins: Settings.minimalMargin
                    source: [SERVER, (modelData[ "file" ][0]["file"])].join("/")
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Item {
                            width: image.width
                            height: image.height

                            Rectangle {
                                anchors.centerIn: parent
                                width: image.width
                                height: image.height
                                radius: 20
                            }
                        }
                    }

                    Rectangle {
                        x: 0
                        y: 0
                        anchors.fill: parent
                        anchors.centerIn: parent
                        color: Qt.rgba(0, 0, 0, 0.6)
                        radius: 20
                    }

                    Text {
                        anchors.centerIn: parent
                        color: "white"
                        font.bold: true
                        font.pointSize: Settings.h6
                        text: "Загрузка"
                        visible: image.status != Image.Ready
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.margins: Settings.defaultmargin
                        color: "white"
                        font.pointSize: Settings.h6
                        font.bold: true
                        text: modelData[ "timestamp" ].split(" ")[0]
                    }
                }

                MouseArea {
                    id: imageMouseHandle
                    anchors.fill: image
                    onClicked: AppLoader.openEffect( loadPage )

                    function loadPage() {
                        AppLoader.pageContent = modelData
                        AppLoader.loadPage("Pages/Story.qml")
                    }
                }
            }
        }
    }

    onAfterInit: {
        AppHeader.title = "Наши моменты"
        AppHeader.color = "transparent"
        AppHeader.addOption( "add.svg", () => AppLoader.loadPage( "Pages/StoryAdd.qml" ) )
        AppHeader.addOption( "play.svg", () => AppLoader.loadPage( "Pages/Playback.qml" ) )
    }
}
