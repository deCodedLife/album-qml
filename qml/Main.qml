import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import "."
import "Base"

AppWindow
{
    width: 450
    height: 720

    x: Settings.is_mobile ? 0 : Screen.width - 460
    y: Settings.is_mobile ? 0 : (Screen.height / 2) - (height / 2)    

    Component.onCompleted:
    {
        Settings.loadStories()
        AppLoader.loadPage( "Pages/Stories.qml" )
    }
}
