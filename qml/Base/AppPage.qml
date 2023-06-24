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
        AppLoader.pageHeight = height

        defaultHeight = height
        afterInit()
    }

    onHeightChanged: {
        if ( height > defaultHeight ) AppLoader.reloadFlickable()
        AppLoader.pageHeight = height
    }
}
