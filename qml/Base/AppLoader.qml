pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    signal reloadFlickable

    property Item imageLayout: null
    property ApplicationWindow root: null

    property double pageHeight: 0
    property var pageContent: [{}]

    property var pagesDom: [ "Pages/HomePage.qml" ]
    property string currentPage: "Pages/HomePage.qml"
    property bool isLoaded: false

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
        lastMousePos = Qt.point( appMouse.mouseX, appMouse.mouseY )
        popupRectangle.createObject( root )
    }
}
