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

    function addOption( icon, action ) {
        let newObject = options.push({ "icon": icon, "action": action })
        options = newObject
    }
}
