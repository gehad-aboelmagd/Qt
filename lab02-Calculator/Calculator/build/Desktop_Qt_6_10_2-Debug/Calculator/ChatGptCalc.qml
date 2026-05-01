import QtQuick 6.5
import QtQuick.Window 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Window {
    width: 300
    height: 400
    visible: true
    title: "Basic Calculator"

    // Calculator state
    property double operand1: 0
    property double operand2: 0
    property string operator: ""
    property bool newInput: true

    // Color constants
    readonly property color numberColor: "#e0e0e0"
    readonly property color operatorColor: "#ff9800"
    readonly property color clearColor: "#f44336"
    readonly property color equalColor: "#4caf50"
    readonly property color textDark: "#333333"
    readonly property color textLight: "#ffffff"

    // Main content with background
    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            // Display
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "white"
                border.color: "#cccccc"
                radius: 5

                Text {
                    id: display
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    text: "0"
                    font.pixelSize: 32
                    font.bold: true
                    color: textDark
                }
            }

            // Button Grid
            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 4
                rowSpacing: 10
                columnSpacing: 10

                // Row 1
                CalcButton {
                    text: "7"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("7")
                }
                CalcButton {
                    text: "8"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("8")
                }
                CalcButton {
                    text: "9"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("9")
                }
                CalcButton {
                    text: "/"
                    buttonColor: operatorColor
                    textColor: textLight
                    onClicked: operatorPressed("/")
                }

                // Row 2
                CalcButton {
                    text: "4"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("4")
                }
                CalcButton {
                    text: "5"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("5")
                }
                CalcButton {
                    text: "6"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("6")
                }
                CalcButton {
                    text: "*"
                    buttonColor: operatorColor
                    textColor: textLight
                    onClicked: operatorPressed("*")
                }

                // Row 3
                CalcButton {
                    text: "1"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("1")
                }
                CalcButton {
                    text: "2"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("2")
                }
                CalcButton {
                    text: "3"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("3")
                }
                CalcButton {
                    text: "-"
                    buttonColor: operatorColor
                    textColor: textLight
                    onClicked: operatorPressed("-")
                }

                // Row 4
                CalcButton {
                    text: "0"
                    buttonColor: numberColor
                    textColor: textDark
                    onClicked: numberPressed("0")
                }
                CalcButton {
                    text: "C"
                    buttonColor: clearColor
                    textColor: textLight
                    onClicked: clearPressed()
                }
                CalcButton {
                    text: "="
                    buttonColor: equalColor
                    textColor: textLight
                    onClicked: equalPressed()
                }
                CalcButton {
                    text: "+"
                    buttonColor: operatorColor
                    textColor: textLight
                    onClicked: operatorPressed("+")
                }
            }
        }
    }

    // Custom Button Component
    component CalcButton: Button {
        id: control
        property color buttonColor: numberColor
        property color textColor: textDark
        property color borderColor: Qt.darker(buttonColor, 1.2)

        Layout.preferredWidth: 60
        Layout.preferredHeight: 60
        Layout.fillWidth: true
        Layout.fillHeight: true

        background: Rectangle {
            color: control.buttonColor
            radius: 5
            border.color: control.borderColor

            // Add a subtle press effect
            opacity: control.pressed ? 0.7 : 1.0
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }

        contentItem: Text {
            text: control.text
            font.pixelSize: 24
            font.bold: true
            color: control.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        // Add hover effects (optional)
        hoverEnabled: true

        ToolTip.visible: hovered
        ToolTip.text: control.text
        ToolTip.delay: 1000
    }

    // Number button handler
    function numberPressed(value) {
        if (newInput || display.text === "0") {
            display.text = value
            newInput = false
        } else {
            // Limit input length to prevent overflow
            if (display.text.length < 12) {
                display.text += value
            }
        }
    }

    // Operator button handler
    function operatorPressed(op) {
        // If there's a pending operation, calculate it first
        if (operator !== "" && !newInput) {
            equalPressed()
        }

        operand1 = parseFloat(display.text)
        operator = op
        newInput = true
    }

    // Equal button handler
    function equalPressed() {
        if (operator === "") return

        operand2 = parseFloat(display.text)
        let result = 0

        switch(operator) {
            case "+":
                result = operand1 + operand2
                break
            case "-":
                result = operand1 - operand2
                break
            case "*":
                result = operand1 * operand2
                break
            case "/":
                if (Math.abs(operand2) > 0.000001) { // Handle floating point precision
                    result = operand1 / operand2
                } else {
                    display.text = "Error"
                    clearAfterError()
                    return
                }
                break
        }

        // Format result to avoid long decimals
        display.text = formatResult(result)
        operator = ""
        newInput = true
    }

    // Clear button handler
    function clearPressed() {
        display.text = "0"
        operand1 = 0
        operand2 = 0
        operator = ""
        newInput = true
    }

    // Helper function to handle division by zero
    function clearAfterError() {
        clearPressed()
    }

    // Helper function to format results
    function formatResult(value) {
        // Round to 10 decimal places max to avoid floating point issues
        let rounded = Math.round(value * 1e10) / 1e10

        // Convert to string
        let result = rounded.toString()

        // Limit total length
        if (result.length > 12) {
            result = rounded.toExponential(6)
        }

        return result
    }
}
