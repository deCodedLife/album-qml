import QtQuick
import Qt5Compat.GraphicalEffects

import ".."

Item {
    id: carousel
    property var images:[]
    property int itemHeight: 0
    clip: true
    height: itemHeight

    ListView {
        anchors.fill: parent
        orientation: ListView.Horizontal
        spacing: Settings.defaultmargin
        currentIndex: 0

        model: images
        delegate: Image {
            states: [
                State {
                    name: "normal"
                    PropertyChanges {
                        target: image
                        width: carousel.width - 50
                        height: itemHeight
                    }
                },
                State {
                    name: "resized"
                    PropertyChanges{
                        target: image
                        width: Settings.root.width
                        height:Settings.root.height
                        x: 0
                        y: 0
                    }
                }

            ]

            width: carousel.width - 50
            height: itemHeight
            fillMode: Image.PreserveAspectCrop

            id: image
            source: [SERVER, modelData[ "file" ]].join("/")
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: image.width
                    height: image.height

                    Rectangle {
                        anchors.centerIn: parent
                        width: image.width
                        height: image.height
                        radius: 20
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    let coords = image.mapToItem( Settings.root, Qt.point(0, 0) )
                    image.parent = Settings.root
                    image.x = coords.x
                    image.y = coords.y
                    image.z = 100
                }
            }
        }
    }
}
