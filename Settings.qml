pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    property ApplicationWindow root: null
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
    property bool isHeaderVisible: true
    property color headerColor: Material.accentColor
    property var headerOptions: []

    function hideHeader() {
        isHeaderVisible = false
    }

    function showHeader() {
        isHeaderVisible = true
    }

    property var pagesDom: [ "Pages/HomePage.qml" ]
    property string currentPage: "Pages/HomePage.qml"

    function loadPage( page ) {
        pagesDom.push( page )
        currentPage = page
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

    function openEffect ( itemComponent, item, cb ) {
        const newObject = Qt.createComponent( "PopupRectangle.qml" )
        newObject.onStatusChanged.connect( (status) => { console.log( status ) } )
        if (newObject.status === Component.Ready) {
            newObject.value = root.height
            newObject.x = appMosue.mouseX
            newObject.y = appMosue.mouseY
        }
        newObject.createObject(root)
        console.log( newObject )
        newObject.destroy(500)
    }
}
