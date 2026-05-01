import QtQuick

Window {
    id: splashWindow
    visible: true
    color: "transparent"
    flags: Qt.SplashScreen
    width: 640
    height: 480
    x: (screen.width - width)/2
    y: (screen.height - height)/2

    property double splashOpacity: 0.0
    property int counter: 0

    Image {
        id: splashImage
        anchors.fill: parent
        source: "qrc:/images/splashflower.jpg"
        fillMode: Image.PreserveAspectCrop
        opacity: splashOpacity
    }

    FontLoader{
        id: customFont
        source: "qrc:/fonts/IndieFlower-Regular.ttf"
    }

    Text{
        id: welcomingText
        text: "Welcome to our Flower Gallery"
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.02
        font.family: customFont.name
        font.pixelSize: 25
        font.bold: true
        color: "green"
        opacity: splashOpacity
    }

    Timer {
        id: fadeInTimer
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            splashOpacity += 0.2
            if(splashOpacity >= 1.0)
            {
                fadeInTimer.stop()
                pauseTimer.start()
            }
        }
    }

    Timer {
        id: pauseTimer
        interval: 200
        running: false
        repeat: true
        onTriggered: {
            counter ++
            if(counter == 5)
            {
                pauseTimer.stop()
                fadeOutTimer.start()
            }
        }
    }

    Timer {
        id: fadeOutTimer
        interval: 250
        running: false
        repeat: true
        onTriggered: {
            splashOpacity -= 0.5
            if(splashOpacity <= 0.0)
            {
                fadeOutTimer.stop()
                var component = Qt.createComponent("MainWindow.qml")
                var mainWindow = component.createObject()
                mainWindow.show()
                splashWindow.close()
            }
        }
    }
}
