import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs

Window {
    width: 800
    height: 480
    visible: true
    // color: "#0f172a"
    color: "#87CEEB"
    title: qsTr("Audio Mediaplayer")

    property bool isRadio : false

    FileDialog {
        id: fileDialog
        title: "Select Audio File"

        fileMode: FileDialog.OpenFile

        nameFilters: [
            "Audio files (*.mp3 *.wav *.ogg)",
            "All files (*)"
        ]

        onAccepted: {
            // file is a URL → pass to C++
            audioPlayer.setAudioSource(selectedFile)
        }
    }

    // Column for all UI elements
    ColumnLayout{
        id: uiContainer
        anchors.fill: parent

        Text {
            id: appName
            color: "white"
            font.bold: true
            font.pixelSize: 25
            text: qsTr("Audio Player")
            Layout.alignment: Qt.AlignCenter
        }

        // app icon + meta data
        RowLayout {
            id: iconMetadata
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Image {
                id: appIcon
                fillMode: Image.PreserveAspectFit
                Layout.preferredHeight: 100
                Layout.preferredWidth: 100
                source: "qrc:/images/headphone.png"
            }

            // meta-data
            ColumnLayout {
                id: metaData

                Text {
                    id: title
                    text: audioPlayer.title.length > 0
                           ? audioPlayer.title
                           : "Unknown"
                    color: "white"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignCenter
                }

                Text {
                    id: author
                    text: audioPlayer.artist.length > 0
                             ? audioPlayer.artist
                             : "Unknown"
                    color: "white"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignCenter
                }

                Text {
                    id: category
                    text: audioPlayer.genre.length > 0
                           ? audioPlayer.genre
                           : "Unknown"
                    color: "white"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
        // text, audio slider, text
        RowLayout {
            id: audioSlider
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            Text {
                id: audioCurrPos
                text: qsTr("00:00")
                color: "white"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignCenter


            }

            Slider {
                Layout.fillWidth: true
                from: 0
                to: audioPlayer.duration
                value: audioPlayer.position

                onMoved: audioPlayer.position = value
            }
            Text {
                id: reminaing
                text: qsTr("40:00")
                color: "white"
                font.pixelSize: 16
            }
        }

        // control
        RowLayout {
            Layout.fillWidth: true
            spacing: 20
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            // Button {
            //     text: "Load"
            //     onClicked: {
            //         fileDialog.open()
            //     }
            // }

            Image
            {
                id: fileOpen
                source: "qrc:/images/open-folder.png"
                Layout.preferredWidth: 35
                Layout.preferredHeight: 35
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        isRadio = false
                       fileDialog.open()
                    }
                }
            }

            Image
            {
                id: radio
                source: "qrc:/images/radio.png"
                Layout.preferredWidth: 35
                Layout.preferredHeight: 35
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        isRadio =true
                        audioPlayer.setRadioSource(0)
                    }
                }
            }

            Item {
                id: spacer1
                Layout.preferredWidth: 40
            }

            Image {
                id: prev
                source: "qrc:/images/skip-previous-circle.svg"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(isRadio)
                        {
                            audioPlayer.playPrevStation()
                        }
                    }
                }
            }

            Image {
                id: playPause
                source:  audioPlayer.playing
                        ? "qrc:/images/play.png"
                        : "qrc:/images/play-music.png"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        audioPlayer.togglePlayPause()
                    }
                }
            }

            Image {
                id: rollBack
                source: "qrc:/images/play.png"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }

            Image {
                id: next
                source: "qrc:/images/skip-next-circle.svg"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(isRadio)
                        {
                            audioPlayer.playNextStation()
                        }
                    }
                }
            }

            Item {
                id: spacer2
                Layout.preferredWidth: 40
            }

            Image {
                id: mute
                source: "qrc:/images/speaker-volume.png"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        onClicked: audioPlayer.muted = !audioPlayer.muted
                        mute.source = audioPlayer.muted ?  "qrc:/images/mute.png" : "qrc:/images/speaker-volume.png"
                        volumeControl.value = audioPlayer.muted ? 0 : volumeControl.value
                    }
                }
            }

            Slider {
                id: volumeControl
                from: 0
                to: 1
                value: audioPlayer.volume
                Layout.fillWidth: true
                Layout.minimumWidth: 100
                Layout.maximumWidth: 200

                onMoved: {
                    audioPlayer.volume = value
                    if(volumeControl.value === 0)
                    {
                        mute.source = "qrc:/images/mute.png"
                    }
                    else
                    {
                        mute.source = "qrc:/images/speaker-volume.png"
                    }
                }
            }

            Text {
                id: volumeLevel
                text: Math.round(audioPlayer.volume * 100) + "%"
                color: "white"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
