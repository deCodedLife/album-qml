import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import "."
import "Base"

import Network

AppWindow
{
    width: 450
    height: 720

    x: Settings.is_mobile ? 0 : Screen.width - 460
    y: Settings.is_mobile ? 0 : (Screen.height / 2) - (height / 2)    

    Component.onCompleted:
    {
        Settings.net = net
        Settings.loadStories()
        AppLoader.loadPage( "Pages/Stories.qml" )
    }

    Network {
        id: net
        function getRequest( cb, url ) {
            net.loaded.connect((data) => cb(data))
            net.loaded.connect(function release () {
                net.loaded.disconnect(cb)
                net.loaded.disconnect(release)
            })
            net.get( url )
        }
    }
}
