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
            delegate: Text {
                text: shortName
                font: control.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                required property string shortName
            }
        }
        MonthGrid {
            id: picker
            locale: Qt.locale("ru_RU")
            Layout.fillWidth: true
            delegate: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: model.month === control.month ? 1 : 0
                text: model.day
                font: control.font
                color: Material.primaryTextColor
            }
        }
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
    }
}
