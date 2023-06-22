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
            id: image
            source: modelData[ "file" ]
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: image.width
                    height: image.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: image.adapt ? image.width : Math.min(image.width, image.height)
                        height: image.adapt ? image.height : width
                        radius: Math.min(width, height)
                    }
                }
            }
        }
    }
}
