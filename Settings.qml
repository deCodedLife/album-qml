pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject
{
    signal domUpdated(string page)

    readonly property int defaultmargin: 16
    readonly property int minimalMargin: 5
    readonly property int h1: 24
    readonly property int h2: 20
    readonly property int h3: 18
    readonly property int h4: 16

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
}
