import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    ColumnLayout {
        width: parent.width
        height: implicitHeight

        DayOfWeekRow {
            locale: picker.locale
            Layout.fillWidth: true
        }
        MonthGrid {
            id: picker
            locale: Qt.locale("ru_RU")
            Layout.fillWidth: true
        }
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
    }
}
