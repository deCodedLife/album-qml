import QtQuick
import QtQuick.Layouts

import ".."
import Network

Item
{
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
                height: parent.width / 2
                width: parent.width / 2

                Image {
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.centerIn: parent
                    sourceSize.width: parent.width - Settings.minimalMargin
                    anchors.margins: Settings.minimalMargin
                    source: [SERVER, (modelData[ "file" ][0]["file"])].join("/")
                    Component.onCompleted: console.log( source )
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
