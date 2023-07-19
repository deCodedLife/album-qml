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

            model: images
            delegate: Flickable {
                id: flick
                clip: true

                width: imageList.width
                height: imageList.height

                contentHeight: Math.max(storyImage.width * storyImage.scale, page.width )
                contentWidth: Math.max( storyImage.height * storyImage.scale, page.height )

                Image {
                    id: storyImage
                    property double zoom: 0.0

//                    anchors.fill: parent
                    anchors.centerIn: parent

                    transformOrigin: Item.Center
                    fillMode: Image.PreserveAspectFit
                    scale: Math.min( flick.width / width, flick.height / height, 1 ) + zoom

                    source: [SERVER, modelData[ "file" ]].join("/")
                }

                PinchHandler {
                    id: pinch
                    target: null
                    onScaleChanged: (delta) => storyImage.zoom += Math.log2(delta)
                    onRotationChanged: (delta) => storyImage.rotation += delta
                }
            }
        }

//        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"
        let imagesList = []
        Settings.storiesList.forEach( story => imagesList.push(...story[ "file" ]) )
        images = imagesList
    }
}
