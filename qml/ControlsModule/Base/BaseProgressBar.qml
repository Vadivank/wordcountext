import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import StyleSettings 1.0

Item {
    id: root
    property double value
    property alias text: textBar.text

    Rectangle {
        id: lineBar
        height: parent.height
        width: parent.width * value
        color: Style.progressBarColor
        radius: 3

        Text {
            id: textBar
            color: Style.textColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            visible: value > 0.1 ? true : false
        }
    }
}
