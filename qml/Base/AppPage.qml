import QtQuick
import QtQuick.Controls.Material

import ".."

Item
{
    id: page
    clip: true

    signal afterInit()
    property int defaultHeight: 0
    property bool isLoaded: true

    Component.onCompleted: {
        AppHeader.options = []
        AppHeader.color = Material.accentColor
        AppHeader.title = ""
        AppHeader.subtitle = ""
        AppHeader.isVisible = true

        defaultHeight = height
        afterInit()
    }

    onHeightChanged: {
        if ( height > defaultHeight && isLoaded ) AppLoader.reloadFlickable()
        AppLoader.pageHeight = height
    }
}
