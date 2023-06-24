import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    ColumnLayout {
        id: datePicker

        width: parent.width
        height: implicitHeight

        property var selectedTime: 0
        property date selectedDate: new Date(selectedTime)
        property alias month: picker.month
        property alias year: picker.year
        property alias locale: picker.locale

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
                property MonthGrid control: picker
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

            onClicked: (date) => datePicker.selectedTime = date.getTime()
        }
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
    }
}
