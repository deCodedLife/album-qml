pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    signal reloadFlickable

    property Item imageLayout: null
    property var root: null

    property double pageHeight: 0
    property var pageContent: [{}]

    property var pagesDom: [ "Pages/HomePage.qml" ]
    property string currentPage: "Pages/HomePage.qml"

    function loadPage( page ) {
        pageHeight = 0
        currentPage = page
        pagesDom.push( page )
    }

    function replacePage( page ) {
        pagesDom.pop()
        loadPage( page  )
    }

    function goBack() {
        pagesDom.pop()
        currentPage = pagesDom[ pagesDom.length - 1 ]
    }

    property MouseArea appMouse: null
    property point lastMousePos: Qt.point(0, 0)
    property Component popupRectangle: Qt.createComponent( "PopupRectangle.qml" )
    property var popupCallback: null

    function openEffect ( cb ) {
        popupCallback = cb
        let point = Qt.point( root.width / 2, root.height / 2 )
        if ( appMouse != null ) point = Qt.point( appMouse.mouseX, appMouse.mouseY )

        lastMousePos = point
        popupRectangle.createObject( root )
    }
}
