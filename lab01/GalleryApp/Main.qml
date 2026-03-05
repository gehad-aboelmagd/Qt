import QtQuick

Window{
    id: entryPointWindow
    visible: false
    width: 640
    height: 480
    x: (screen.width - width)/2
    y: (screen.height - height)/2

    Component.onCompleted: {
        var component = Qt.createComponent("SplashWindow.qml")
        var splashWindow = component.createObject()
        splashWindow.show()
    }
}
