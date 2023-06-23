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
        id: body
        anchors.fill: parent
        orientation: ListView.Horizontal
        spacing: Settings.defaultmargin
        currentIndex: 0

        model: images
        delegate: Image {
            property var originParent: null
            property int rounded: 20

            state: "normal"

            states: [
                State {
                    name: "normal"
                    PropertyChanges {
                        target: image
                        width: carousel.width - 50
                        height: itemHeight
                        layer.enabled: true
                        rounded: 20
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
                        rounded: 0
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
                        radius: image.rounded
                    }
                }
            }

            transitions: Transition {
                NumberAnimation {
                    target: image
                    properties: "width,height,x,y"
                    easing.type: Easing.InOutQuart
                    duration: 500
                }
            }

            function animationAfter() {
                image.x = 0
                image.y = 0

                if ( image.state === "normal" ) {
                    image.destroy()
                } else {
                    body.model = body.model.splice( image.originIndex, 1 )
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if ( image.state === "normal" ) {
                        let coords = image.mapToItem( Settings.root, Qt.point(0, 0) )
                        image.parent = Settings.imageLayout
                        image.x = coords.x
                        image.y = coords.y
                        image.z = 100
                        image.state = "resized"
                    } else {
                        image.parent = parent
                        image.x = 0
                        image.y = 0
                        image.z = 0
                        image.state = "normal"

                        image.originParent.model = []
                        image.originParent.model = images
                    }
                }
            }

            Component.onCompleted: originParent = body
        }
    }
}
