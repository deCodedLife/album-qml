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
            source: modelData
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: img.width
                    height: img.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: img.adapt ? img.width : Math.min(img.width, img.height)
                        height: img.adapt ? img.height : width
                        radius: Math.min(width, height)
                    }
                }
            }
        }
    }
}
