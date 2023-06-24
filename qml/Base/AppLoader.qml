pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    property Item imageLayout: null
    property ApplicationWindow root: null

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



    property MouseArea appMouse: null
    property point lastMousePos: Qt.point(0, 0)
    property Component popupRectangle: Qt.createComponent( "PopupRectangle.qml" )

    function openEffect ( cb ) {
        lastMousePos = Qt.point( appMouse.mouseX, appMouse.mouseY )
        popupRectangle.finished.connect( cb )
        let object = popupRectangle.createObject( root )
    }
}
