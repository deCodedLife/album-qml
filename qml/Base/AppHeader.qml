pragma Singleton

import QtQuick
import QtQuick.Controls.Material

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
        isVisible = false
    }

    function show() {
        isVisible = true
    }

    function addOptions( icon, action ) {
        let newObject = options
        newObject.push({ "icon": icon, "action": action })
        options = []
        options = newObject
    }
}
