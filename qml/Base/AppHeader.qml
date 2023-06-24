pragma Singleton

import QtQuick

QtObject {
    property string title: ""
    property string subtitle: ""
    property bool isVisible: true
    property color color: Material.accentColor

    /** {
      *   "icon": "",
      *   "action" () => {}
      * }
    */
    property var options: []

    function hide() {
        isHeaderVisible = false
    }

    function show() {
        isHeaderVisible = true
    }

    function addOptions( icon, action ) {
        let newObject = headerOptions
        newObject.push({ "icon": icon, "action": action })
        headerOptions = []
        headerOptions = newObject
    }
}
