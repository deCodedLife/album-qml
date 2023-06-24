import QtQuick
import QtQuick.Controls.Material

import ".."

Item
{
    id: page
    clip: true

    signal afterInit()

    Component.onCompleted: {
        AppHeader.options = []
        AppHeader.color = Material.accentColor
        AppHeader.title = ""
        AppHeader.subtitle = ""
        AppHeader.isVisible = true
        console.log( 1 )
        afterInit()
    }

    onHeightChanged: AppLoader.setHeight( height )
}
