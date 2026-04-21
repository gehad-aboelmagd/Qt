import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 650
    title: "Weather App"
    color: "#1a1a2e"

    // Sample data (would come from C++ backend)
    property string cityName: "Cairo"
    property string temperature: "72"
    property string condition: "Partly Cloudy"
    property int humidity: 65
    property int windSpeed: 12
    property int vis: 14
    property string highTemp: "78"
    property string lowTemp: "62"
    property string apiCall: "http://api.weatherapi.com/v1/forecast.json?key=ea923024c9434d8ea29100515262104&q=Cairo&days=5&aqi=no&alerts=no"

    property var forecastData:
    [
        {day: "Sat", icon: "☁️", temp: "68°"},
        {day: "Tue", icon: "☀️", temp: "72°"},
        {day: "Wed", icon: "🌧️", temp: "65°"},
        {day: "Thu", icon: "☁️", temp: "70°"},
        {day: "Fri", icon: "☀️", temp: "75°"}
    ]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Header with location and settings
        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "📍 " + cityName
                font.pixelSize: 20
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignLeft
            }

            Button {
                text: "⚙️"
                flat: true
                onClicked: console.log("Settings clicked")
                Layout.alignment: Qt.AlignRight
                background: Rectangle {
                    color: "transparent"
                }
            }
        }

        // Main weather display
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 200

            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: temperature + "°"
                    font.pixelSize: 72
                    font.bold: true
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: condition
                    font.pixelSize: 24
                    color: "#aaaaff"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "H:" + highTemp + "°  L:" + lowTemp + "°"
                    font.pixelSize: 16
                    color: "#8888aa"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // Weather details card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#16213e"
            radius: 15

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 30

                Column {
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        text: "💧"
                        font.pixelSize: 28
                    }
                    Text {
                        text: humidity + "%"
                        font.pixelSize: 18
                        color: "white"
                    }
                    Text {
                        text: "Humidity"
                        font.pixelSize: 12
                        color: "#8888aa"
                    }
                }

                Column {
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        text: "💨"
                        font.pixelSize: 28
                    }
                    Text {
                        text: windSpeed + " km/h"
                        font.pixelSize: 18
                        color: "white"
                    }
                    Text {
                        text: "Wind Speed"
                        font.pixelSize: 12
                        color: "#8888aa"
                    }
                }

                Column {
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        text: "👁️"
                        font.pixelSize: 28
                    }
                    Text {
                        text: vis + " km"
                        font.pixelSize: 18
                        color: "white"
                    }
                    Text {
                        text: "Visibility"
                        font.pixelSize: 12
                        color: "#8888aa"
                    }
                }
            }
        }

        // 5-day forecast
        Text {
            text: "5-DAY FORECAST"
            font.pixelSize: 16
            font.bold: true
            color: "white"
            Layout.topMargin: 10
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 5
            columnSpacing: 10
            rowSpacing: 10

            Repeater {
                model: forecastData

                Rectangle {
                    width: 60
                    height: 90
                    color: "#16213e"
                    radius: 10

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: modelData.day
                            font.pixelSize: 14
                            color: "white"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: modelData.icon
                            font.pixelSize: 28
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: modelData.temp
                            font.pixelSize: 16
                            color: "#aaaaff"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }

        // Refresh button
        Button {
            text: "🔄 Refresh"
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 10
            onClicked: {
                console.log("Refresh clicked")
                getWeather()
            }

            background: Rectangle {
                color: "#e94560"
                radius: 20
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }


    function sendRequest(url, callback)
    {
        let request = new XMLHttpRequest();

        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if(request.status === 200)
                {
                    console.log("succeeded...")
                    callback(request.responseText)
                }
            }
        }

        request.open("GET", url);
        request.send();
    }

    function getIconForCondition(condition) {
            condition = condition.toLowerCase()

            if (condition.includes("sunny")) return "☀️"
            if (condition.includes("clear")) return "🌙"
            if (condition.includes("partly cloudy")) return "⛅"
            if (condition.includes("cloudy")) return "☁️"
            if (condition.includes("rain")) return "🌧️"
            if (condition.includes("thunder")) return "⛈️"
            if (condition.includes("snow")) return "❄️"
            if (condition.includes("mist") || condition.includes("fog")) return "🌫️"
            return "🌤️"  // Default
        }

    function getWeather()
    {
        sendRequest(apiCall, function(response)
        {
            response = JSON.parse(response)
            cityName = response.location.name
            temperature = response.current.temp_c
            highTemp = response.forecast.forecastday[0].day.maxtemp_c
            lowTemp = response.forecast.forecastday[0].day.mintemp_c
            condition = response.current.condition.text
            humidity = response.current.humidity
            windSpeed = response.current.wind_kph
            vis = response.current.vis_km

            const days = ['Sun', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat'];
            const today = new Date();
            const newForecastData = []

            for (var i = 0; i < response.forecast.forecastday.length; i++) {
                const day = days[today.getDay() + i]
                const icon = getIconForCondition(response.forecast.forecastday[i].day.condition.text)
                const temp = response.forecast.forecastday[i].day.avgtemp_c
                newForecastData.push(
                            {day: day, icon: icon, temp: temp}
                )
            }

            forecastData = newForecastData
        }
            )
    }

}
