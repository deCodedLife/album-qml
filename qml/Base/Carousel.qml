import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    property var images:[]

    clip: true

    ListView {
        anchors.fill: parent
        layoutDirection: Qt.Horizontal

        model: images
        delegate: Image {
            width: parent.width - 50
            height: parent.height
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
        }
    }
}
