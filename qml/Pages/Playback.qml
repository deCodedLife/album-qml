import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Settings.defaultmargin

        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"
    }
}
