import QtQuick

import ".."

Item {
    id: page


    onHeightChanged: Settings.setHeight( height )
    Component.onCompleted: {
        Settings.headerTitle = ""
        Settings.headerSubtitle = ""
        Settings.showHeader()
        Settings.setHeight( page.height )
    }
}
