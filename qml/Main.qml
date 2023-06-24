import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "."
import "Base"

AppWindow
{
    id: root

    width: 420
    height: Settings.is_mobile ? 780 : 730

    x: Settings.is_mobile ? 0 : Screen.width - 460
    y: Settings.is_mobile ? 0 : (Screen.height / 2) - (height / 2)    

    ColumnLayout {
        id: page
        anchors.fill: parent
        spacing: 0

        HeaderComponent {
            id: appHeader
            Layout.fillWidth: true
        }

        PageLoader {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: {
        AppLoader.loadPage( "Pages/Stories.qml" )
    }
}
