// import QtQuick

// Window {
//     width: 300
//     height: 400
//     visible: true
//     title: qsTr("Weather App")
// }

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 600
    title: "Weather App"

    // Background gradient (now using simple Rectangle with gradient)
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1e3c72" }
            GradientStop { position: 1.0; color: "#2a5298" }
        }
    }

    // Main content
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Header with search
        RowLayout {
            Layout.fillWidth: true

            TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: "Search city..."
                placeholderTextColor: "#ffffff"
                background: Rectangle {
                    radius: 20
                    color: "white"
                    opacity: 0.2
                    border.color: "white"
                    border.width: 1
                }
                color: "white"
                font.pixelSize: 16
                leftPadding: 15
            }

            Button {
                id: searchButton
                text: "🔍"
                font.pixelSize: 20
                background: Rectangle {
                    radius: 20
                    color: searchButton.pressed ? "#4a6fa5" : "white"
                    opacity: 0.3
                    border.color: "white"
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                width: 50
                height: 40
            }
        }

        // Main weather card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            radius: 30
            color: "white"
            opacity: 0.15
            border.color: "white"
            border.width: 1

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "New York"
                    font.pixelSize: 32
                    font.bold: true
                    color: "white"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "☀️"
                    font.pixelSize: 80
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "24°C"
                    font.pixelSize: 48
                    font.bold: true
                    color: "white"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Sunny"
                    font.pixelSize: 18
                    color: "white"
                    opacity: 0.8
                }
            }
        }

        // Weather details row
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            // Humidity
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                radius: 20
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "💧"
                        font.pixelSize: 24
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Humidity"
                        font.pixelSize: 14
                        color: "white"
                        opacity: 0.7
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "65%"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }
            }

            // Wind Speed
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                radius: 20
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "💨"
                        font.pixelSize: 24
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Wind"
                        font.pixelSize: 14
                        color: "white"
                        opacity: 0.7
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "12 km/h"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }
            }

            // Pressure
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                radius: 20
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "📊"
                        font.pixelSize: 24
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Pressure"
                        font.pixelSize: 14
                        color: "white"
                        opacity: 0.7
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "1012 hPa"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }

        // 5-day forecast section
        Text {
            text: "5-Day Forecast"
            font.pixelSize: 18
            font.bold: true
            color: "white"
        }

        // Forecast items
        RowLayout {
            Layout.fillWidth: true
            spacing: 5

            // Day 1
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                radius: 15
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: "Mon"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "☀️"
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "22°"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Day 2
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                radius: 15
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: "Tue"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "⛅"
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "20°"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Day 3
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                radius: 15
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: "Wed"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "☁️"
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "19°"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Day 4
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                radius: 15
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: "Thu"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "🌧️"
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "18°"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Day 5
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                radius: 15
                color: "white"
                opacity: 0.15
                border.color: "white"
                border.width: 1

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: "Fri"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "☀️"
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: "23°"
                        color: "white"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }

        // Last updated
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Last updated: Just now"
            color: "white"
            opacity: 0.5
            font.pixelSize: 12
        }
    }
}
