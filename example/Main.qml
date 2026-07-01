import QtQuick
import AppChrome 1.0

AppChrome {
    id: window

    width: 640
    height: 480

    title: qsTr("My custom caption example")

    caption: Component {
        CustomCaption {}
    }

    content: Rectangle {

        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#05010A" }
            GradientStop { position: 0.5; color: "#1A0B2E" }
            GradientStop { position: 1.0; color: "#0B1B3A" }
        }

        Text {
            text: "YOUR CUSTOM CONTENT"
            color: "#E6D6FF"
            font.pixelSize: 28
            font.bold: true

            anchors.centerIn: parent

            style: Text.Outline
            styleColor: "#3A1B5A"
        }
    }
}

