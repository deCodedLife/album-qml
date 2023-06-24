import QtQuick
import QtQuick.Controls.Material

import ".."

Item
{
    id: page
    clip: true

    signal afterInit()
    property int defaultHeight: 0

    Component.onCompleted: {
        AppHeader.options = []
        AppHeader.color = Material.accentColor
        AppHeader.title = ""
        AppHeader.subtitle = ""
        AppHeader.isVisible = true
        defaultHeight = height
        AppLoader.pageHeight = height

        afterInit()
    }

    onHeightChanged: {
        if ( height > defaultHeight ) AppLoader.reloadFlickable()
        AppLoader.pageHeight = height
    }
}
