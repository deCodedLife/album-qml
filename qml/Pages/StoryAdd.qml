import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    ColumnLayout {
        id: body
        anchors.fill: parent
        anchors.topMargin: Settings.defaultmargin
        anchors.leftMargin: Settings.defaultmargin
        anchors.rightMargin: Settings.defaultmargin

        CalendarComponent {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
        AppLoader.isLoaded = true
    }
}
