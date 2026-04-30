
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import RPI_LED_Control 1.0

ApplicationWindow {
    visible: true
    width: 400
    height: 550
    title: "LED Controller"
    color: "#1a1a2e"

    property bool ledOn: false

    BackEnd{
        id: ledController
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 25
        width: 280

        // Title
        Text {
            text: "LED Control Panel"
            color: "#00d4ff"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 10
        }

        // LED Circle with animation
        Rectangle {
            width: 130
            height: 130
            radius: 65
            color: ledOn ? "#00ff88" : "#2a2a3e"
            border.color: ledOn ? "#00ff88" : "#555"
            border.width: 3
            Layout.alignment: Qt.AlignCenter

            Behavior on color {
                ColorAnimation { duration: 200 }
            }

            // Icon/Text inside LED
            Text {
                text: ledOn ? "●" : "○"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 40
                opacity: ledOn ? 1 : 0.5
            }
        }

        // Status Card
        Rectangle {
            width: 200
            height: 50
            radius: 10
            color: ledOn ? "#003300" : "#2a2a3e"
            border.color: ledOn ? "#00ff88" : "#555"
            border.width: 1
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 10

            Text {
                text: ledOn ? "STATUS: ACTIVE" : "STATUS: INACTIVE"
                anchors.centerIn: parent
                color: ledOn ? "#00ff88" : "#aaa"
                font.bold: true
                font.pixelSize: 14
            }
        }

        // Button Row
        RowLayout {
            spacing: 15
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 10

            // ON Button
            Button {
                text: "ON"
                width: 80
                height: 45

                background: Rectangle {
                    color: parent.pressed ? "#008844" : (parent.hovered ? "#00aa55" : "#00cc66")
                    radius: 8
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked:{
                    ledOn = true
                    ledController.turnLedOn()
                }
            }

            // OFF Button
            Button {
                text: "OFF"
                width: 80
                height: 45

                background: Rectangle {
                    color: parent.pressed ? "#aa0000" : (parent.hovered ? "#cc3333" : "#ff4444")
                    radius: 8
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    ledOn = false
                    ledController.turnLedOff()
                }
            }

            // TOGGLE Button
            Button {
                text: "TOGGLE"
                width: 80
                height: 45

                background: Rectangle {
                    color: parent.pressed ? "#0088aa" : (parent.hovered ? "#00aacc" : "#00ccff")
                    radius: 8
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if(ledOn)
                    {
                        ledController.turnLedOff()
                    }
                    else
                    {
                        ledController.turnLedOn()
                    }
                    ledOn = !ledOn
                }
            }
        }
    }


}
