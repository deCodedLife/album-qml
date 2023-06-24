import QtQuick
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{

    Calendar {
    }

    onAfterInit: {
        AppHeader.color = "transparent"
        AppHeader.title = "Новое событие"
    }
}
