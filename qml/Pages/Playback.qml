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
        anchors.margins: Settings.defaultmargin

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

                contentHeight: Math.max( storyImage.width * storyImage.scale, page.width )
                contentWidth: Math.max( storyImage.height * storyImage.scale, page.height )

                Image {
                    id: storyImage

                    property double zoom: 0.0
                    property double zoomStem: 0.1

                    width: parent.width
                    height: parent.height

                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Center
                    scale: Math.min( page.width / width, page.height / height, 1 ) + zoom

                    source: [SERVER, modelData[ "file" ]].join("/")
                }

                onRotationChanged: (delta) => storyImage.rotation -= delta
                onScaleChanged: (delta) => storyImage.scale += Math.log2(delta)

                WheelHandler {
                    id: wheel
                    target: storyImage
                    acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland" ? PointerDevice.Mouse | PointerDevice.TouchPad : PointerDevice.Mouse
                    rotationScale: 1 / 120
                    property: "rotation"
                }
            }
        }

        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"
        let imagesList = []
        Settings.storiesList.forEach( story => imagesList.push(...story[ "file" ]) )
        images = imagesList
    }
}
