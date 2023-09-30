import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material

import "."
import "Base"

AppWindow
{
    width: 450
    height: 720

    x: Settings.is_mobile ? 0 : Screen.width - 460
    y: Settings.is_mobile ? 0 : (Screen.height / 2) - (height / 2)    

    function getData( url ) : async {
        var request = new XMLHttpRequest();
        request.open('GET', url, true);

        request.onreadystatechange = function () {
            console.log( 'YOOOOO' )
            if (request.readyState === 4 && request.status === 200) {
                Settings.fireworkImage = request.responseText
            }
        }

        request.send(null);
    }

    onAfterInit: {
//        getData( [SERVER, QML, "Images/fireworks.gif"].join("/") )

        Settings.loadStories()
        let currentDate = new Date().getDate()

        // Check birthday's TODO: Move data to server
        for ( let index in Settings.birthdayDates ) {

            let birthday = Settings.birthdayDates[ index ]
            if ( currentDate === birthday[ "date" ].getDate() ) {
                Settings.currentTheme = Material.Light
                AppLoader.loadPage( "Pages/Birthday.qml" )
                return
            }

        }

        AppLoader.loadPage( "Pages/Stories.qml" )
    }
}
