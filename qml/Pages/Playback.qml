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

                contentHeight: Math.max(storyImage.width, page.width )
                contentWidth: Math.max( storyImage.height, page.height )

                Image {
                    id: storyImage

                    property double zoom: 0.0
                    property double zoomStem: 0.1

                    width: parent.width
                    height: parent.height

                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    scale: Math.min( page.width / width, page.height / height, 1 ) + zoom

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
