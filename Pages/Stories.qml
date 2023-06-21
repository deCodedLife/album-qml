import QtQuick
import QtQuick.Layouts

import ".."
import Network

Item
{
    anchors.fill: parent

    function parseData( data ) {
        let response = JSON.parse( data )
        let storiesIDs = []
        for ( let i = 0; i < data[ "data" ].length; i++ ) {
            storiesIDs.push( response[ "data" ][ i ][ "id" ] )
        }

    }

    ColumnLayout {
        anchors.fill: parent
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
            net.loaded.triggered.connect((data) => cb(data))
            net.loaded.triggered.connect(function release () {
                net.loaded.triggered.disconnect(cb)
                net.loaded.triggered.disconnect(release)
            })
            net.get( url )
        }
    }
}
