import QtQuick
import QtQuick.Controls.Material

import ".."

Item {
    id: page
    clip: true

    signal afterInit

    AppHeader.options: []
    AppHeader.color: Material.accentColor
    AppHeader.title: ""
    AppHeader.subtitle: ""
    AppHeader.isVisible: true

    Component.onCompleted: afterInit()
    onHeightChanged: AppLoader.setHeight( height )
}
