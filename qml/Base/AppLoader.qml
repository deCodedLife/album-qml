pragma Singletom

import QtQuick

import ".."

QtObject {
    signal popupEnded()

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
        lastMousePos = Qt.point( Settings.appMouse.mouseX, Settings.appMouse.mouseY )
        let object = popupRectangle.createObject( Settings.root)
    }
}
