import QtQuick 2.0
import QtQuick.Layouts 1.12

import ControlsModule.Base 1.0

BaseProgressBar {
    height: 20
    Layout.fillWidth: true

    text: parseInt(value * 100) + "%"
}
