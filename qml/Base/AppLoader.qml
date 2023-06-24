pragma Singleton

import QtQuick
import QtQuick.Controls.Material 2.0

QtObject {
    signal popupEnded()

    property ApplicationWindow root: null
    property MouseArea appMouse: null

    property double pageHeight: 0
    property var pageContent: [{}]

    property var pagesDom: [ "Pages/HomePage.qml" ]
    property string currentPage: "Pages/HomePage.qml"
//    property var popupCallback: null

    function loadPage( page ) {
        pageHeight = 0
        currentPage = page
        pagesDom.push( page )
    }

    function setHeight( height ) {
        pageHeight = Math.max( pageHeight, height )
    }

    function goBack() {
        pagesDom.pop()
        currentPage = pagesDom[ pagesDom.length - 1 ]
    }

    property Item imageLayout: null
    property var lastMousePos: Qt.point(0, 0)
    property Component popupRectangle: Qt.createComponent( "PopupRectangle.qml" )

    function openEffect () {
        lastMousePos = Qt.point( appMouse.mouseX, appMouse.mouseY )
        let object = popupRectangle.createObject( root)
    }
}
