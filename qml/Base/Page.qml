import QtQuick
import QtQuick.Controls.Material

import ".."

Item {
    id: page
    clip: true

    signal afterInit

    Header.options: []
    Header.color: Material.accentColor
    Header.title: ""
    Header.subtitle: ""
    Header.isVisible: true

    Component.onCompleted: afterInit()
    onHeightChanged: Loader.setHeight( height )
}
