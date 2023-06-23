import QtQuick
import QtQuick.Controls.Material

import ".."

Item {
    id: page
    clip: true

    signal afterInit
    onHeightChanged: Settings.setHeight( height )

    Component.onCompleted: {
        Settings.headerOptions = []
        Settings.headerColor = Material.accentColor
        Settings.headerTitle = ""
        Settings.headerSubtitle = ""
        Settings.showHeader()
        Settings.setHeight( page.height )
        afterInit()
    }
}
