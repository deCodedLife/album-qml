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

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: Settings.storiesList
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

                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Center
                    scale: Math.min( page.width / width, page.height / height, 1 ) + zoom

                    source: [SERVER, modelData[ "file" ]].join("/")
                }

                MouseArea {
                    anchors.fill: parent

                }

                onRotationChanged: (delta) => storyImage.rotation -= delta
                onScaleChanged: (delta) => storyImage.scale += Math.log2(delta)

                WheelHandler {
                    id: wheel
                    target: storyImage
                    acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland" ? PointerDevice.Mouse | PointerDevice.TouchPad : PointerDevice.Mouse
                    rotationScale: 1 / 120
                    property: "scale"
                }

                DragHandler {
                    id: drag
                    target: storyImage
                    onTranslationChanged: function (delta) {
                        storyImage.x = delta.x
                        storyImage.y += delta.y
                    }
                }
            }
        }

        Rectangle { Layout.fillHeight: true }
    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"

        Settings.storiesList.forEach( story => images.push(...story[ "file" ]) )
        console.log( JSON.stringify( images ) )
    }
}
