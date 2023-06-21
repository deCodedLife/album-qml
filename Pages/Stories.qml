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
        console.log(storiesIDs)
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
            net.loaded.connect((data) => cb(data))
            net.loaded.connect(function release () {
                net.loaded.disconnect(cb)
                net.loaded.disconnect(release)
            })
            net.get( url )
        }
    }
}
