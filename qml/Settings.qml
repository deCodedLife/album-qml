pragma Singleton

import QtQuick
import QtQuick.Controls.Material

import Network

QtObject
{
    property ApplicationWindow root: null
    property Network net: null
    property MouseArea appMouse: null
    property bool is_mobile: checkPlatform()

    readonly property int defaultmargin: 16
    readonly property int minimalMargin: 5
    readonly property int h1: 24
    readonly property int h2: 20
    readonly property int h3: 18
    readonly property int h4: 16
    readonly property int h5: 14
    readonly property int h6: 12
    readonly property int h7: 10

    property int currentTheme: Material.Dark
    property int currentAccent: Material.Green

    function checkPlatform() {
        if ( Qt.platform.os === "android" ) return true
        if ( Qt.platform.os === "ios" ) return true
        return false
    }

    property var storiesList: []
    function loadStories() {
        net.getRequest(
            (data) => storiesList = JSON.parse(data)[ "data" ],
            [ SERVER, "api", "s_stories" ].join("/")
        )
    }
}
