import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

BaseCaption {
    implicitHeight: 64
    width: window.width

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 32

            Item {
                Layout.preferredWidth: 80
            }

            Label {
                text: window.title

                Layout.fillWidth: true

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: 18
                font.bold: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                text: "Your space for custom design"

                Layout.fillWidth: true

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: 18
                font.bold: true

                background: Rectangle {
                    anchors.fill: parent

                    color: "purple"
                }
            }
        }
    }
}