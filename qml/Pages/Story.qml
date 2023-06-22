import QtQuick

import ".."

Item {
    anchors.fill: parent

    Component.onCompleted:
    {
        Settings.headerTitle = ""
        Settings.showHeader()
        console.log( JSON.stringify( Settings.pageContent ) )
    }
}
