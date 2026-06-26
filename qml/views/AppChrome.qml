import QtQuick 2.15

AppMainWindow {
    id: window

    visible: false

    AppCaption {}

    Component.onCompleted: {
        // Performs platform-specific window initialization.
        window.setup()

        window.visible = true
    }
}
