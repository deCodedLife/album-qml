import QtQuick
import Qt5Compat.GraphicalEffects

import ".."

Item {
    property var images:[]
    property int itemHeight: 0
    clip: true
    height: itemHeight

    ListView {
        anchors.fill: parent
        orientation: ListView.Horizontal
        layoutDirection: Qt.Horizontal
        spacing: Settings.defaultmargin

        model: images
        delegate: Image {
            width: parent.width - 50
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
        }
    }

    Component.onCompleted: console.log( JSON.stringify( images ) )
}
