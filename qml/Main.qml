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

    onAfterInit: {
        Settings.loadStories()
        let currentDate = new Date().getDate()

        // Check birthday's TODO: Move data to server
        for ( let index in Settings.birthdayDates ) {

            let birthday = Settings.birthdayDates[ index ]
            if ( currentDate === birthday[ "date" ].getDate() ) {
                Settings.currentTheme = Material.Light
                AppLoader.openEffect( () => AppLoader.loadPage( "Pages/Birthday.qml" ) )
                return
            }

        }

        AppLoader.loadPage( "Pages/Stories.qml" )
    }
}
