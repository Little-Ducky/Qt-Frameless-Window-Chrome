import QtQuick 2.15
import QtQuick.Layouts

AppMainWindow {
    id: window

    property Component caption: defaultCaption
    default property alias content: container.data

    visible: false

    Component {
        id: defaultCaption

        DefaultAppCaption {
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#26133D"
                }

                GradientStop {
                    position: 0.5
                    color: "#1D102F"
                }

                GradientStop {
                    position: 1.0
                    color: "#130A22"
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent;

        spacing: 0

        Loader {
            id: captionLoader
            sourceComponent: window.caption
        }

        Item {
            id: container

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }


    Component.onCompleted: {
        // Performs platform-specific window initialization.
        window.setup()

        window.visible = true
    }
}
