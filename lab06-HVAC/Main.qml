import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes

Window {
    id: root
    width: 400
    height: 800
    visible: true
    color: "#fff3f8"
    title: "Climate Control"

    property real temperature: 22
    property real minTemp: 16
    property real maxTemp: 30

    Item {
        id: systemStatus
        property bool isOn:      true
        property int  roomTemp:  temperature
    }

    Item {
        id: fanSpeedSection
        property int selectedFan: 0   // 0=Auto, 1=Low, 2=Med, 3=High, 4=Max
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent

        RowLayout {
            id: banner
            spacing: 10
            Layout.topMargin: 12

            Image {
                id: flowerIcon
                sourceSize.width: 25
                sourceSize.height: 25
                source: "qrc:/icons/sakura.png"
                Layout.leftMargin: 20
            }

            Text {
                id: title
                text: "Climate"
                color: "#d5667f"
                font.pixelSize: 20
                font.bold: true
            }
        }

        // ── Temperature Dial ──────────────────────────────────
        Item {
            id: tempDial
            width: 220
            height: 220
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 12

            // Layer 1 – outermost glossy ring
            Rectangle {
                id: outerRing
                anchors.fill: parent
                radius: width / 2
                color: "#ffd6ea"

                // Gloss highlight overlay (top-left bright arc)
                Rectangle {
                    width: parent.width * 0.55
                    height: parent.height * 0.55
                    radius: width / 2
                    x: parent.width * 0.08
                    y: parent.height * 0.06
                    color: "white"
                    opacity: 0.25
                }
            }

            // Layer 2 – arc progress drawn on Canvas
            Canvas {
                id: arcCanvas
                anchors.fill: parent

                // Repaint whenever temperature changes
                Connections {
                    target: root
                    function onTemperatureChanged() { arcCanvas.requestPaint() }
                }

                onPaint: {
                    var ctx = getContext("2d")
                    var cx  = width  / 2
                    var cy  = height / 2
                    var r   = cx - 14          // arc sits inside outerRing

                    var startDeg  = 135
                    var sweepDeg  = 270
                    var startRad  = startDeg * Math.PI / 180
                    var sweepRad  = sweepDeg * Math.PI / 180
                    var progress  = (root.temperature - root.minTemp)
                            / (root.maxTemp    - root.minTemp)

                    ctx.clearRect(0, 0, width, height)

                    // Track (full 270° ring, muted pink)
                    ctx.beginPath()
                    ctx.arc(cx, cy, r, startRad, startRad + sweepRad)
                    ctx.strokeStyle = "#f0b0ca"
                    ctx.lineWidth   = 10
                    ctx.lineCap     = "round"
                    ctx.stroke()

                    // Active fill (deep pink, proportional to temp)
                    if (progress > 0.001) {
                        ctx.beginPath()
                        ctx.arc(cx, cy, r, startRad,
                                startRad + sweepRad * progress)
                        ctx.strokeStyle = "#e8326e"
                        ctx.lineWidth   = 10
                        ctx.lineCap     = "round"
                        ctx.stroke()
                    }
                }
            }

            // Layer 3 – inner display circle
            Rectangle {
                id: innerCircle
                anchors.centerIn: parent
                width: 148
                height: 148
                radius: width / 2
                color: "#fff0f6"

                // Gloss spot
                Rectangle {
                    width: 40
                    height: 40
                    radius: 20
                    x: 30
                    y: 22
                    color: "white"
                    opacity: 0.45
                }

                // Temperature value
                Text {
                    id: tempText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter:   parent.verticalCenter
                    anchors.verticalCenterOffset: -8
                    text: root.temperature.toFixed(0) + "°"
                    font.pixelSize: 44
                    font.bold: true
                    color: "#c0366a"

                    // Animate the number smoothly
                    Behavior on text {}
                }

                // Sub-label
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: tempText.bottom
                    anchors.topMargin: 2
                    text: "set temp"
                    font.pixelSize: 11
                    color: "#e07099"
                }
            }

            // Smooth value animation
            Behavior on implicitWidth {}
        }


        RowLayout
        {
            id: tempInfo
            spacing: 85
            Layout.alignment: Qt.AlignCenter

            Rectangle
            {
                width: 80
                height: 25
                radius: 8
                color: "#ffd0e5"

                Text {
                    id: minValue
                    anchors.centerIn: parent
                    color: "#c0366a"
                    font.pixelSize: 12
                    font.bold: true
                    text: "Min " + minTemp.toString() + " °C"
                }
            }

            Rectangle
            {
                width: 80
                height: 25
                radius: 8
                color: "#cc2564"

                Text {
                    id: maxValue
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    text: "Max " + maxTemp.toString() + " °C"
                }
            }
        }

        RowLayout
        {
            id: tempControl
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 12
            spacing: 12

            Rectangle
            {
                width: 120
                height: 50
                radius: 10
                color: "#fff3f8"
                border.color: "#595556"
                border.width: 1

                Text {
                    id: minusSign
                    anchors.centerIn: parent
                    text: "-"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#595556"
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if(root.temperature > root.minTemp)
                        {
                            root.temperature -= 1
                        }
                    }
                    onPressed:  parent.color = "#c02060"
                    onReleased: parent.color = "#fff3f8"
                }
            }

            Rectangle
            {
                width: 120
                height: 50
                radius: 10
                color: "#fff3f8"
                border.color: "#595556"
                border.width: 1

                Text {
                    id: maxSign
                    anchors.centerIn: parent
                    text: "+"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#595556"
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if(root.temperature < root.maxTemp)
                        {
                            root.temperature += 1
                        }
                    }
                }
            }
        }

        // ── AC Mode ───────────────────────────────────────────────
        Rectangle {
            id: acModeCard
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 12
            Layout.bottomMargin: 8
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.fillWidth: true
            height: 110
            radius: 20
            color: "#f9dae6"

            // Section label
            Text {
                id: acModeLabel
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 12
                anchors.leftMargin: 16
                text: "AC MODE"
                font.pixelSize: 11
                font.bold: true
                color: "#d060a0"
                // letterSpacing: 1.5
            }

            // Mode buttons row
            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.bottomMargin: 12
                spacing: 8

                Repeater {
                    id: modeRepeater

                    model: ListModel {
                        ListElement { label: "Cool"; modeId: 0; iconSource: "qrc:/icons/snow.png"  }
                        ListElement { label: "Heat"; modeId: 1; iconSource: "qrc:/icons/thermometer.png"  }
                        ListElement { label: "Dry";  modeId: 2; iconSource: "qrc:/icons/dry.png"   }
                        ListElement { label: "Auto"; modeId: 3; iconSource: "qrc:/icons/spiral.png"  }
                    }

                    delegate: Rectangle {
                        id: modeBtn
                        Layout.fillWidth: true
                        height: 60
                        radius: 14

                        color: acModeSection.selectedMode === modeId
                               ? "#e8326e"
                               : "#ffdaec"

                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }

                        Column {
                            anchors.centerIn: parent
                            spacing: 3

                            // ── Custom icon image (replaces Canvas) ──
                            Image {
                                id: modeIcon
                                width: 22
                                height: 22
                                anchors.horizontalCenter: parent.horizontalCenter
                                source: iconSource
                                sourceSize.width: 22
                                sourceSize.height: 22
                                fillMode: Image.PreserveAspectFit

                                // Tint white when active using ColorOverlay
                                layer.enabled: true
                                // layer.effect: ColorOverlay {
                                //     color: acModeSection.selectedMode === modeId
                                //            ? "white"
                                //            : "#c0608a"

                                //     Behavior on color {
                                //         ColorAnimation { duration: 150 }
                                //     }
                                // }
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: label
                                font.pixelSize: 11
                                font.bold: true
                                color: acModeSection.selectedMode === modeId
                                       ? "white"
                                       : "#c0608a"

                                Behavior on color {
                                    ColorAnimation { duration: 150 }
                                }
                            }
                        }

                        scale: modeMouseArea.containsPress ? 0.95 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                        }

                        MouseArea {
                            id: modeMouseArea
                            anchors.fill: parent
                            onClicked: acModeSection.selectedMode = modeId
                        }
                    }

                }
            }
        }

        // ── Fan Speed ─────────────────────────────────────────────
        Rectangle {
            id: fanSpeedCard
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 12
            Layout.bottomMargin: 8
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.fillWidth: true
            height: 110
            radius: 20
            color: "#fff0f6"

            // Section label
            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 12
                anchors.leftMargin: 16
                text: "FAN SPEED"
                font.pixelSize: 11
                font.bold: true
                color: "#d060a0"
            }

            // Speed buttons row
            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.bottomMargin: 12
                spacing: 8

                Repeater {
                    id: fanRepeater

                    model: ListModel {
                        ListElement { label: "Auto"; fanId: 0; barCount: 1 }
                        ListElement { label: "Low";  fanId: 1; barCount: 2 }
                        ListElement { label: "Med";  fanId: 2; barCount: 3 }
                        ListElement { label: "High"; fanId: 3; barCount: 4 }
                        ListElement { label: "Max";  fanId: 4; barCount: 5 }
                    }

                    delegate: Rectangle {
                        id: fanBtn
                        Layout.fillWidth: true
                        height: 60
                        radius: 14

                        color: fanSpeedSection.selectedFan === fanId
                               ? "#e8326e"
                               : "#ffdaec"

                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            // ── Bar indicator ──
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 2

                                Repeater {
                                    model: barCount

                                    Rectangle {
                                        width: 4
                                        // Each bar is taller than the previous
                                        height: 4 + (index * 3)
                                        radius: 2
                                        anchors.bottom: barRow.bottom

                                        color: fanSpeedSection.selectedFan === fanId
                                               ? "white"
                                               : "#c0608a"

                                        Behavior on color {
                                            ColorAnimation { duration: 150 }
                                        }
                                    }
                                }

                                // Invisible bottom anchor item for bar alignment
                                id: barRow
                                // Align bars to bottom by using a helper
                            }

                            // Speed label
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: label
                                font.pixelSize: 10
                                font.bold: true
                                color: fanSpeedSection.selectedFan === fanId
                                       ? "white"
                                       : "#c0608a"

                                Behavior on color {
                                    ColorAnimation { duration: 150 }
                                }
                            }
                        }

                        scale: fanMouseArea.containsPress ? 0.95 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                        }

                        MouseArea {
                            id: fanMouseArea
                            anchors.fill: parent
                            onClicked: fanSpeedSection.selectedFan = fanId
                        }
                    }
                }
            }
        }

        // ── System Status f─────────────────────────────────────
        Rectangle {
            id: statusBar
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 12
            height: 52
            radius: 16
            color: "#fff0f6"

            // Left side — status dot + text
            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 16
                spacing: 8

                // Pulsing status dot
                Rectangle {
                    id: statusDot
                    width: 10
                    height: 10
                    radius: 5
                    anchors.verticalCenter: parent.verticalCenter
                    color: systemStatus.isOn ? "#50d080" : "#f0a8c0"

                    Behavior on color {
                        ColorAnimation { duration: 400 }
                    }

                    // Pulse animation when system is on
                    SequentialAnimation {
                        id: pulseAnim
                        running: systemStatus.isOn
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: statusDot
                            property: "opacity"
                            from: 1.0
                            to: 0.4
                            duration: 800
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: statusDot
                            property: "opacity"
                            from: 0.4
                            to: 1.0
                            duration: 800
                            easing.type: Easing.InOutSine
                        }
                    }

                    // Reset opacity when turned off
                    onColorChanged: {
                        if (!systemStatus.isOn) {
                            statusDot.opacity = 1.0
                        }
                    }
                }

                // Status text
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: systemStatus.isOn ? "System Running" : "System Off"
                    font.pixelSize: 12
                    font.bold: true
                    color: "#c0508a"

                    Behavior on color {
                        ColorAnimation { duration: 300 }
                    }
                }
            }

            // Right side — room temperature
            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 16
                spacing: 6

                // Small thermometer icon (Canvas)
                Canvas {
                    id: roomTempIcon
                    width: 12
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle  = "#d070a0"
                        ctx.strokeStyle = "#d070a0"
                        ctx.lineWidth  = 1.2
                        ctx.lineCap    = "round"

                        // Tube outline
                        ctx.beginPath()
                        ctx.roundRect(3.5, 0, 5, 9, 2.5)
                        ctx.stroke()

                        // Mercury fill
                        ctx.beginPath()
                        ctx.roundRect(4.5, 3, 3, 6, 1.5)
                        ctx.fill()

                        // Bulb
                        ctx.beginPath()
                        ctx.arc(6, 13, 3, 0, Math.PI * 2)
                        ctx.fill()
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Room: " + systemStatus.roomTemp + "°C"
                    font.pixelSize: 12
                    font.bold: true
                    color: "#d070a0"
                }
            }

            // Subtle top border for separation
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                height: 1
                color: "#f0b0d0"
                opacity: 0.5
            }
        }
    }   // end ColumnLayout
}       // end Window

