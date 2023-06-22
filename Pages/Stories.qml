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
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.centerIn: parent
                    sourceSize.height: parent.height - Settings.minimalMargin
                    anchors.margins: Settings.minimalMargin
                    source: [SERVER, (modelData[ "file" ][0]["file"])].join("/")
                    Component.onCompleted: console.log( source )
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
                    anchors.margins: Settings.minimalMargin
                    color: "white"
                    font.pointSize: Settings.h6
                    text: modelData[ "timestamp" ]
                }
            }
        }

    }

    Component.onCompleted: {
        Settings.headerTitle = "Наши моменты"
        Settings.headerColor = "transparent"
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
