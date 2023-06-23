pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    property ApplicationWindow root: null
    property Item imageLayout: null
    property MouseArea appMosue: null
    property bool is_mobile: checkPlatform()

    readonly property int defaultmargin: 16
    readonly property int minimalMargin: 5
    readonly property int h1: 24
    readonly property int h2: 20
    readonly property int h3: 18
    readonly property int h4: 16
    readonly property int h5: 14
    readonly property int h6: 12

    property int currentTheme: Material.Dark
    property int currentAccent: Material.Red

    property string headerTitle: ""
    property string headerSubtitle: ""
    property bool isHeaderVisible: true
    property color headerColor: Material.accentColor

    /** {
      *   "icon": "",
      *   "action" () => {}
      * }
    */
    property var headerOptions: []

    function hideHeader() {
        isHeaderVisible = false
    }

    function showHeader() {
        isHeaderVisible = true
    }

    property var pagesDom: [ "Pages/HomePage.qml" ]
    property string currentPage: "Pages/HomePage.qml"
    property var pageContent: [{}]
    property double pageHeight: 0

    function loadPage( page ) {
        pageHeight = 0
        pagesDom.push( page )
        currentPage = page
    }

    function setHeight( height ) {
        pageHeight = Math.max( pageHeight, height )
    }

    function goBack() {
        pagesDom.pop()
        currentPage = pagesDom[ pagesDom.length - 1 ]
    }

    function checkPlatform() {
        if ( Qt.platform.os === "android" ) return true
        if ( Qt.platform.os === "ios" ) return true
        return false
    }

    property Component popupRectangle: Qt.createComponent( "PopupRectangle.qml" )
    property var popupCallback: null
    property var lastMousePos: Qt.point(0, 0)

    function openEffect () {
        lastMousePos = Qt.point( appMosue.mouseX, appMosue.mouseY )
        let object = popupRectangle.createObject(root)
    }

    function newHeaderOptions( icon, action ) {
        let newObject =  JSON.parse(JSON.stringify(headerOptions))
        newObject.push({ "icon": icon, "action": action })
        headerOptions = newObject
    }
}
