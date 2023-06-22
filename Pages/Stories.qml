import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import ".."
import Network

Item
{
    id: page

    anchors.fill: parent
    anchors.leftMargin:  Settings.is_mobile ? 0 : Settings.minimalMargin
    anchors.rightMargin:  Settings.is_mobile ? 0 : Settings.minimalMargin
    anchors.bottomMargin:  Settings.is_mobile ? 0 : Settings.defaultmargin
    clip: true

    property var storiesList: []

    function parseData( data ) {
        let response = JSON.parse( data )
        storiesList = response[ "data" ]
    }

    ColumnLayout {
        anchors.fill: parent

        GridView {
            id: grid
            clip: true
            cacheBuffer: 999
            Layout.fillWidth: true
            height: parent.height
            cellWidth: parent.width / 2
            cellHeight: parent.width / 2
            flickableDirection: Flickable.VerticalFlick

            model: storiesList
            delegate: Item {
                height: page.width / 2
                width: page.width / 2

                Image {
                    id: image
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.centerIn: parent
                    sourceSize.height: parent.height - Settings.minimalMargin
                    anchors.margins: Settings.minimalMargin
                    source: [SERVER, (modelData[ "file" ][0]["file"])].join("/")
                }

                MouseArea {
                    id: imageMouseHandle
                    anchors.fill: image
                    property var mousePos: Qt.point(0, 0)
                    propagateComposedEvents: false

                    onMouseXChanged: mouse.accepted = false
                    onMouseYChanged: mouse.accepted = false
                    onPressAndHold: mouse.accepted = false
                    onPressed: mouse.accepted = false
                    onReleased: {
                        if (!propagateComposedEvents) {
                                propagateComposedEvents = true
                            }
                        mouse.accepted = false
                        if ( mousePos.x != mouseX || mousePos.y != mouseY ) return
                        Settings.popupCallback = () => Settings.loadPage("Pages/HomePage.qml")
                        Settings.openEffect()
                    }

//                    onClicked: {
//                        mouse.accepted = false
//                        mousePos = Qt.point( mouseX, mouseY )
//                    }
                }

                Rectangle {
                    x: 0
                    y: 0
                    anchors.fill: parent
                    anchors.centerIn: parent
                    anchors.margins: Settings.minimalMargin
                    color: Qt.rgba(0, 0, 0, 0.6)
                }


                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.margins: Settings.defaultmargin
                    color: "white"
                    font.pointSize: Settings.h6
                    font.bold: true
                    text: modelData[ "timestamp" ].split(" ")[0]
                }
            }
        }

    }

    Component.onCompleted: {
        Settings.headerTitle = "Наши моменты"
        Settings.headerColor = "transparent"
        Settings.showHeader()
        net.getRequest( parseData, [ SERVER, "api", "s_stories" ].join("/") )
    }

    Network {
        id: net

        onLoaded: ( data ) => parseData( data )
        function getRequest( cb, url ) {
            net.loaded.connect((data) => cb(data))
            net.loaded.connect(function release () {
                net.loaded.disconnect(cb)
                net.loaded.disconnect(release)
            })
            net.get( url )
        }
    }
}
