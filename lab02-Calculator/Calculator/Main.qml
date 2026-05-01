import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window
{
    id: root
    visible: true
    width: 300
    height: 400
    color: gridColor
    title: qsTr("My Calculator")

    property int gridSpacing: 10
    property int gridRadius: 5
    property font gridFont:( {pixelSize: 20, bold: true,})
    property string gridColor: "#f1f2f6"
    property string displayColor: "#ffffff"
    property string numBtnColor: "#dfe4ea"
    property string signBtnColor: "#ffa502"
    property string clearBtnColor: "#ff4757"
    property string equalBtnColor: "#2ed573"
    property string borderColor: "#ced6e0"

    property string displayText: "0"
    property string firstOperand: ""
    property string secondOperand: ""
    property string operator: ""
    property bool newInput: true

    GridLayout
    {
        id: layout
        anchors.fill: parent
        anchors.margins: gridSpacing
        rowSpacing: gridSpacing
        columnSpacing: gridSpacing
        rows: 5
        columns: 4

        Rectangle
        {
            id: display
            radius: gridRadius
            color: displayColor
            border.color: "#ced6e0"
            Layout.row: 0
            Layout.column: 0
            // Layout.rowSpan: 1
            Layout.columnSpan: 4
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text
            {
                font: gridFont
                text: displayText
                anchors.centerIn: parent
            }
        }

        CalcButton{
            rowIndex: 1
            colIndex: 0
            btnColor: numBtnColor
            btnText: "7"
            onClicking: numberPressed("7")
        }

        CalcButton{
            rowIndex: 1
            colIndex: 1
            btnColor: numBtnColor
            btnText: "8"
            onClicking: numberPressed("8")
        }

        CalcButton{
            rowIndex: 1
            colIndex: 2
            btnColor: numBtnColor
            btnText: "9"
            onClicking: numberPressed("9")
        }

        CalcButton{
            rowIndex: 1
            colIndex: 3
            btnColor: signBtnColor
            btnText: "/"
            onClicking: operatorPressed("/")
        }

        CalcButton{
            rowIndex: 2
            colIndex: 0
            btnColor: numBtnColor
            btnText: "4"
            onClicking: numberPressed("4")
        }

        CalcButton{
            rowIndex: 2
            colIndex: 1
            btnColor: numBtnColor
            btnText: "5"
            onClicking: numberPressed("5")
        }

        CalcButton{
            rowIndex: 2
            colIndex: 2
            btnColor: numBtnColor
            btnText: "6"
            onClicking: numberPressed("6")
        }

        CalcButton{
            rowIndex: 2
            colIndex: 3
            btnColor: signBtnColor
            btnText: "*"
            onClicking: operatorPressed("*")
        }

        CalcButton{
            rowIndex: 3
            colIndex: 0
            btnColor: numBtnColor
            btnText: "1"
            onClicking: numberPressed("1")
        }

        CalcButton{
            rowIndex: 3
            colIndex: 1
            btnColor: numBtnColor
            btnText: "2"
            onClicking: numberPressed("2")
        }

        CalcButton{
            rowIndex: 3
            colIndex: 2
            btnColor: numBtnColor
            btnText: "3"
            onClicking: numberPressed("3")
        }

        CalcButton{
            rowIndex: 3
            colIndex: 3
            btnColor: signBtnColor
            btnText: "-"
            onClicking: operatorPressed("-")
        }

        CalcButton{
            rowIndex: 4
            colIndex: 0
            btnColor: numBtnColor
            btnText: "0"
            onClicking: numberPressed("0")
        }

        CalcButton{
            rowIndex: 4
            colIndex: 1
            btnColor: clearBtnColor
            btnText: "C"
            onClicking: clearPressed()
        }

        CalcButton{
            rowIndex: 4
            colIndex: 2
            btnColor: equalBtnColor
            btnText: "="
            onClicking: equalPressed()
        }

        CalcButton{
            rowIndex: 4
            colIndex: 3
            btnColor: signBtnColor
            btnText: "+"
            onClicking: operatorPressed("+")
        }

    }

    component CalcButton:
    Rectangle
    {
        property int rowIndex: 0
        property int colIndex: 0
        property string btnColor: ""
        property string btnText: ""
        signal clicking

        radius: gridRadius
        color: btnColor
        border.color: borderColor
        Layout.row: rowIndex
        Layout.column: colIndex
        // Layout.rowSpan: 1
        // Layout.columnSpan: 1
        Layout.fillWidth: true
        Layout.fillHeight: true
        opacity: mouseArea.pressed ? 0.6 : 1

        Text {
            anchors.centerIn: parent
            font: gridFont
            text: btnText
        }

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            onClicked: clicking()
        }
    }

    function numberPressed(num)
    {
        if(newInput)
        {
            displayText = num
            newInput = false
        }
        else if(displayText === "0")
        {
            displayText = num
        }
        else
        {
            displayText += num
        }
    }

    function operatorPressed(oper)
    {
        if(firstOperand !== "")
        {
            equalPressed()
        }
            firstOperand = displayText
            operator = oper
            newInput = true
    }

    function equalPressed()
    {
        if(firstOperand!=="" && operator!=="")
        {
            secondOperand = displayText

            let operand1 = parseFloat(firstOperand)
            let operand2 = parseFloat(secondOperand)
            let result = 0

            switch(operator)
            {
            case "*":
                result = operand1 * operand2
                break
            case "/":
                if(operand2 !== 0)
                {
                    result = operand1 / operand2
                }
                break
            case "+":
                result = operand1 + operand2
                break
            case "-":
                result = operand1 - operand2
                break
            }

            displayText = String(result)
            firstOperand = displayText
            secondOperand = ""
            operator = ""
            newInput = true
        }
    }

    function clearPressed()
    {
        displayText = "0"
        firstOperand = secondOperand = ""
        operator = ""
        newInput = true
    }
}
