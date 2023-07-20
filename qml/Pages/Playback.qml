import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import "../Base"

AppPage
{
    id: page
    property var images: []
    property int delaySec: 5

    ColumnLayout {
        anchors.fill: parent

        ProgressBar {
            id: progress
            Layout.fillWidth: true
            to: delaySec

            Timer {
                id: progressTimer
                interval: 0.01
                repeat: true
                onTriggered: {
                    progress.value += interval
                }
            }

            function stop () {
                progress.value = 0
                progressTimer.stop()
            }
        }

        ListView {
            id: imageList

            orientation: ListView.Horizontal
            Layout.fillWidth: true
            Layout.fillHeight: true
            interactive: false

            model: images
            delegate: Flickable {
                id: flick
                clip: true

                width: page.width
                height: imageList.height

                boundsMovement: Flickable.FollowBoundsBehavior
                boundsBehavior: Flickable.DragAndOvershootBounds
                contentHeight: Math.max(storyImage.height * storyImage.scale, flick.height )
                contentWidth: Math.max( storyImage.width * storyImage.scale, imageList.width )

                Image {
                    id: storyImage
                    width: page.width
                    height: flick.height
                    anchors.centerIn: parent
                    transformOrigin: Item.Center
                    fillMode: Image.PreserveAspectFit
                    scale: Qt.KeepAspectRatio
                    source: [SERVER, modelData[ "file" ]].join("/")

                    transitions: Transition {
                        NumberAnimation {
                            target: imageItem
                            properties: "scale,rotation"
                            easing.type: Easing.InOutQuart
                            duration: 500
                        }
                    }

                    PinchHandler {
                        id: pinch
                        maximumScale: 3
                        minimumScale: 0.5

                        onActiveChanged: {
                            if ( active ) {
                                nextStory.stop()
                                progress.stop()
                            }
                            else reset.start()
                        }
                    }
                }

                onFlickStarted: {
                    nextStory.stop()
                    reset.stop()
                    progress.stop()
                }
                onFlickEnded: reset.start()

                Timer {
                    id: reset
                    interval: 3 * 1000
                    onTriggered: {
                        flick.returnToBounds()
                        storyImage.scale = Qt.KeepAspectRatio
                        storyImage.rotation = 0
                        progressTimer.start()
                        nextStory.start()
                    }
                }
            }
        }        

        Timer {
            id: nextStory
            running: true
            interval: delaySec * 1000
            repeat: true
            onTriggered: imageList.currentIndex++
        }

    }

    onAfterInit: {
        AppHeader.title = ""
        AppHeader.color = "transparent"
        let imagesList = []
        Settings.storiesList.forEach( story => imagesList.push(...story[ "file" ]) )
        images = imagesList
    }
}
