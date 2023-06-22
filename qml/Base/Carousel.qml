import QtQuick
import Qt5Compat.GraphicalEffects

import ".."

Item {
    property var images:[]
    anchors.margins: Settings.defaultmargin
    clip: true
    height: 500

    ListView {
        anchors.fill: parent
        flickableDirection: Qt.Horizontal
        layoutDirection: Qt.Horizontal
        spacing: Settings.defaultmargin

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
