import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{

    Button {
        Layout.preferredWidth: 32
        Layout.preferredHeight: 32

        id: actionButton
        icon.source: [SERVER, QML, "Images/back.svg"].join("/")
        icon.color: Material.primaryTextColor
        icon.width: 24
        icon.height: 24
        flat: true
        padding: 0
        topInset: 0
        bottomInset: 0
        verticalPadding: 0
        leftPadding: 0
        rightPadding: 0

        onClicked: AppLoader.goBack()

        width: 32
        height: 32

        x: Settings.defaultmargin
        y: Settings.defaultmargin

        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Settings.defaultmargin

        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.hide()
    }
}
