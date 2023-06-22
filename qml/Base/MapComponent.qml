import QtQuick
import QtLocation
import QtPositioning

Item {
    Plugin {
        id: mapPlugin
        preferred: [ "here", "asm" ]
        required: Plugin.AnyMappingFeatures | Plugin.AnyGeocodingFeatures
        locales: [ "ru_RU" ]

        PluginParameter {
            name: "osm.mapping.host"
            value: "http://a.tile.openstreetmap.org/"
        }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        zoomLevel: 16
        property geoCoordinate startCenroid
        center: QtPositioning.coordinate(44.97739, 34.10428)
        activeMapType: map.supportedMapTypes[7]

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: {
                if ( active ) {
                    map.startCenroid = map.toCoordinate( pinch.centroid.positio, false )
                }
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint( map.startCenroid, pinch.centroid.position )
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint( map.startCenroid, pinch.centroid.position )
            }
        }

        WheelHandler {
            id: wheel
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland" ? PointerDevice.Mouse | PointerDevice.TouchPad : PointerDevice.Mouse
            rotationScale: 1 / 120
            property: "zoomLevel"
        }

        DragHandler {
            id: drag
            target: null
            onTranslationChanged: delta => map.pan( -delta.x, -delta.y )
        }

        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round( map.zoomLevel + 1 )
        }

        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round( map.zoomLevel - 1 )
        }
    }

    Component.onCompleted: {
        Settings.headerTitle = "Hot reload updated!"
        Settings.hideHeader()
//        Settings.showHeader()
    }
}
