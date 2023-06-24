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

        property var selectedTime: 0
        property date selectedDate: new Date(selectedTime)
        property alias month: grid.month
        property alias year: grid.year
        property alias locale: grid.locale

        DayOfWeekRow {
            locale: picker.locale
            Layout.fillWidth: true
            font.bold: true

            delegate: Text {
                text: shortName
                font: control.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Material.primaryTextColor

                required property string shortName
            }
        }
        MonthGrid {
            id: picker
            locale: Qt.locale("ru_RU")
            Layout.fillWidth: true
            font.bold: true

            delegate: Text {
                property bool isCurrentItem: model.date.getTime() === selectedTime

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: model.day
                font: control.font
                color: Material.primaryTextColor
                opacity: model.month === control.month ? 1 : 0.5

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -4
                    radius: height / 2
                    visible: isCurrentItem
                    color: Material.accentColor
                    z: -2
                }
            }

            onClicked: (date) => selectedTime = date.getTime()
        }
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
    }
}
