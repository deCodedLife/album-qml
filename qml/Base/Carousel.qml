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

        states: [
            State {
                name: "normal"
            },
            State {
                name: "resized"
            }

        ]

        property var originParent: null
        Component.onCompleted: originParent = carousel

        onStateChanged: {
            let childrenLength = model.length
            for ( let i = 0; i < childrenLength; i++ ) {
                currentIndex = i
                let image = currentItem
                image.state = body.state
            }
        }

        model: images
        delegate: Image {
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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if ( image.state === "normal" ) {
                        let coords = image.mapToItem( Settings.root, Qt.point(0, 0) )
                        body.parent = Settings.imageLayout
                        body.state = "resized"
                    } else {
                        body.parent = body.originParent
                        body.state = "normal"
                    }
                }
            }
        }
    }
}
