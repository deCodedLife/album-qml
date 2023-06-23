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

        x: 0
        y: 0

        states: [
            State { name: "normal" },
            State {
                name: "resized"
                PropertyChanges {
                    target: body
                    x: 0
                    y: 0
                    width: Settings.imageLayout.width
                    height:Settings.imageLayout.height
                }
            }

        ]

        property var originParent: null
        property int itemSelected: 0


        Component.onCompleted: originParent = carousel

        transitions: Transition {
            NumberAnimation {
                target: body
                properties: "width,height,x,y"
                easing.type: Easing.InOutQuart
                duration: 500
            }
        }

        onStateChanged: {
            let childrenLength = model.length
            for ( let i = 0; i < childrenLength; i++ ) {
                currentIndex = i
                let image = currentItem
                image.state = body.state
            }
            currentIndex = itemSelected
        }

        model: images
        delegate: Image {
            property int rounded: 20
            property var globalCoords: null

            state: "normal"

            states: [
                State { name: "normal" },
                State {
                    name: "resized"
                    PropertyChanges{
                        target: image
                        rounded: 0
                        width: body.width
                        height: Math.min( sourceSize.height, body.height )
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation {
                    target: image
                    properties: "width,height"
                    easing.type: Easing.InOutQuart
                    duration: 500
                }
            }

            width: body.width - 50
            height: body.height
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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    body.itemSelected = index
                    if ( image.state === "normal" ) {
                        body.parent = Settings.imageLayout
                        body.x = body.mapToItem( Settings.root, Qt.point(0, 0) ).x
                        body.y = body.mapToItem( Settings.root, Qt.point(0, 0) ).y
                        body.state = "resized"
                    } else {
                        body.state = "normal"
                        Settings.imageLayout.hide()
                        let coords = body.mapToItem( Settings.root, Qt.point(0, 0) )
                        animationTimeout.addAction( () => {
                            body.parent = body.originParent
                        }, 600 )
                    }
                }
            }
        }

        Timer {
            id: animationTimeout
            repeat: false

            function addAction( cb, duration ) {
                animationTimeout.interval = duration
                animationTimeout.triggered.connect( cb )
                animationTimeout.triggered.connect( function afterCB () {
                    animationTimeout.triggered.disconnect( cb )
                    animationTimeout.triggered.disconnect( afterCB )
                } )
                animationTimeout.start()
            }
        }
    }
}
