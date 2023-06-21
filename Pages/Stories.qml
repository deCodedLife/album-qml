import QtQuick
import QtQuick.Layouts

import ".."
import Network

Item
{
    anchors.fill: parent

    property var storiesList: []

    function parseData( data ) {
        let response = JSON.parse( data )
        storiesList = resource[ "data" ]
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            model: storiesList
            delegate: Image {
                source: SERVER + ( modelData[ "file" ][0]["file"] ?? "" )
            }
        }

    }

    Component.onCompleted: {
        Settings.headerTitle = "Наши моменты"
        Settings.headerColor = "transparent"
        net.getRequest( parseData, [ SERVER, "api", "stories" ].join("/") )
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
