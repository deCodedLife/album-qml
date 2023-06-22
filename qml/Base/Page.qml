import QtQuick
import QtQuick.Controls.Material

import ".."

Item {
    id: page
    clip: true

    onHeightChanged: Settings.setHeight( height )
    Component.onCompleted: {
        Settings.headerColor = Material.accentColor
        Settings.headerTitle = ""
        Settings.headerSubtitle = ""
        Settings.showHeader()
        Settings.setHeight( page.height )
    }
}
