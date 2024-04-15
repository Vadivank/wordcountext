import QtQuick 2.0

import StyleSettings 1.0

Rectangle {
    property alias text: txt.text
    border.color: Style.secondaryBackgroundColor
    Text {
        id: txt
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: Style.extreamallyTextColor
        font: Style.fontFamilyCourier
    }
}
