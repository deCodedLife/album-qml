import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    id: page
    property var images: []

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: imageList

            orientation: ListView.Horizontal
            Layout.fillWidth: true
            Layout.fillHeight: true
            interactive: false

            model: images
            delegate: Flickable {
                id: flick
                clip: true

                width: page.width
                height: imageList.height

                boundsMovement: Flickable.FollowBoundsBehavior
                boundsBehavior: Flickable.DragAndOvershootBounds

                contentHeight: Math.max(storyImage.height * storyImage.scale, flick.height )
                contentWidth: Math.max( storyImage.width * storyImage.scale * 1.5, imageList.width )

                Image {
                    property double zoom: 0.0
                    id: storyImage
                    width: page.width
                    height: flick.height
                    anchors.centerIn: parent
                    transformOrigin: Item.Center
                    fillMode: Image.PreserveAspectFit
                    scale: Qt.KeepAspectRatio
                    source: [SERVER, modelData[ "file" ]].join("/")
                }

                PinchHandler {
                    id: pinch
                    target: storyImage

                    maximumScale: 3
                    minimumScale: 0.5
                }
            }
        }

        Timer
        {
            interval: 3 * 1000
            repeat: true
            onTriggered: imageList.currentIndex++
        }

    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"
        let imagesList = []
        Settings.storiesList.forEach( story => imagesList.push(...story[ "file" ]) )
        images = imagesList
    }
}
