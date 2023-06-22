import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import Network

Item
{
    id: page

    anchors.fill: parent
    clip: true

    property var storiesList: []

    function parseData( data ) {
        let response = JSON.parse( data )
        storiesList = response[ "data" ]
    }

    ColumnLayout {
        anchors.fill: parent

        GridView {
            id: grid
            clip: true
            cacheBuffer: 999
            Layout.fillWidth: true
            height: parent.height
            cellWidth: parent.width / 2
            cellHeight: parent.width / 2

            model: storiesList
            delegate: Item {
                height: page.width / 2
                width: page.width / 2

                Image {
                    id: image
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.centerIn: parent
                    sourceSize.height: parent.height - Settings.minimalMargin
                    anchors.margins: Settings.minimalMargin
                    source: [SERVER, (modelData[ "file" ][0]["file"])].join("/")
                }

                MouseArea {
                    id: imageMouseHandle
                    anchors.fill: image
                    onClicked: {
                        Settings.popupCallback = () => {
                            Settings.pageContent = modelData
                            Settings.loadPage("Pages/Story.qml")
                        }
                        Settings.openEffect()
                    }
                }

                Rectangle {
                    x: 0
                    y: 0
                    anchors.fill: parent
                    anchors.centerIn: parent
                    anchors.margins: Settings.minimalMargin
                    color: Qt.rgba(0, 0, 0, 0.6)
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
        }

    }

    Component.onCompleted: {
        Settings.headerTitle = "Наши моменты"
        Settings.headerColor = "transparent"
        Settings.showHeader()
        net.getRequest( parseData, [ SERVER, "api", "s_stories" ].join("/") )
    }

    Network {
        id: net

        onLoaded: ( data ) => parseData( data )
        function getRequest( cb, url ) {
            net.loaded.connect((data) => cb(data))
            net.loaded.connect(function release () {
                net.loaded.disconnect(cb)
                net.loaded.disconnect(release)
            })
            net.get( url )
        }
    }
}
