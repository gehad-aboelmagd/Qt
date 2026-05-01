import QtQuick
import QtQuick.Controls

Window{
    id: mainWindow
    width: 640
    height: 480
    x: (screen.width - width)/2
    y: (screen.height - height)/2
    color: "#f9e9ef"
    title: "Gallery"

    FontLoader{
        id: customFont
        source: "qrc:/fonts/IndieFlower-Regular.ttf"
    }

    Row{
        id: homeMenu
        anchors.horizontalCenter: parent.horizontalCenter
        y: 25
        spacing: mainWindow.width * 0.1

        Rectangle{
            id: dateRect
            width: 150
            height: 50
            color:mainWindow.color

            Text {
                id: dateText
                anchors.centerIn: parent
                font.family: customFont.name
                font.pixelSize: 25
                font.bold: true
                color: "green"
                // text: "yyyy - MM - dd"
            }
        }

        Rectangle{
            id: timeRct
            width: 150
            height: 50
            color:mainWindow.color

            Text {
                id: timeText
                anchors.centerIn: parent
                font.family: customFont.name
                font.pixelSize: 25
                font.bold: true
                color: "green"
                // text: "hh : mm : ss"
            }
        }

        Rectangle{
            id: aboutRect
            width: 150
            height: 50
            color:mainWindow.color

            Text{
                id: aboutText
                anchors.centerIn: parent
                font.family: customFont.name
                font.pixelSize: 25
                font.bold: true
                color: "green"
                text: "About"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("about us")
                    aboutPopup.open()
                }
            }
        }
    }

    ListView{
        id: gallery
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.25
        width: parent.width * 0.8
        height: parent.height * 0.4
        spacing: 20
        orientation: Qt.Horizontal

        model: ListModel {
            ListElement { imageSource: "qrc:/images/flower1.jpg"; imageInfo:"flower1 info"}
            ListElement { imageSource: "qrc:/images/flower2.jpg"; imageInfo:"flower2 info"}
            ListElement { imageSource: "qrc:/images/flower3.jpg"; imageInfo:"flower3 info"}
            ListElement { imageSource: "qrc:/images/flower4.jpg"; imageInfo:"flower4 info"}
            ListElement { imageSource: "qrc:/images/flower5.jpg"; imageInfo:"flower5 info"}
            ListElement { imageSource: "qrc:/images/flower6.jpg"; imageInfo:"flower6 info"}
            ListElement { imageSource: "qrc:/images/flower7.jpg"; imageInfo:"flower7 info"}
            ListElement { imageSource: "qrc:/images/flower8.jpg"; imageInfo:"flower8 info"}
        }

        delegate: Image{
            width: 250
            height: 200
            fillMode: Image.PreserveAspectFit
            source: imageSource

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imageInfoRect.visible = true
                    imageInfoText.text = imageInfo
                }
            }
        }
    }

    Rectangle{
        id: imageInfoRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.8
        width: parent.width * 0.8
        height: parent.height * 0.2
        color: mainWindow.color
        visible: false
        Text{
            id: imageInfoText
            anchors.centerIn: parent
            font.family: customFont.name
            font.pixelSize: 25
            font.bold: true
            color: "green"
            text: ""
        }
    }

    Popup{
        id: aboutPopup
        width: 400
        height: 250
        anchors.centerIn: parent
        modal: true
        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape

        contentItem: Rectangle{
            id: popupRect
            anchors.fill: parent
            color: "#fcf4f7"

            Text{
                id: popupText
                anchors.centerIn: parent
                text: "Hi, this is Gehad Aboelmage's own flower gallery.\nTake a look at owr products.\n"
                horizontalAlignment: Text.AlignHCenter
                font.family: customFont.name
                font.pixelSize: 18
                font.bold: true
                color: "green"
            }

            Button{
                width: 100
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height * 0.75
                background: Rectangle{
                    color: popupRect.color
                    radius: 10
                }
                text: "close"
                font.bold: true
                font.family: customFont.name
                font.pixelSize: 18
                onClicked: {
                    aboutPopup.close()
                }
            }
        }
    }

    Timer{
        id: timeUpdateTimer
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            var now = new Date()
            dateText.text = Qt.formatDateTime(now, "yyyy - MM - dd")
            timeText.text = Qt.formatDateTime(now, "hh : mm : ss")
        }
    }
}

