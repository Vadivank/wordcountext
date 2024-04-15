import QtQuick 2.12
import QtQuick.Controls 2.12

import StyleSettings 1.0

Switch {
    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: parent.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: checked ? "#17a81a" : "#ffffff"
        border.color: checked ? "#17a81a" : "#cccccc"

        Rectangle {
            x: checked ? parent.width - width : 0
            width: 26
            height: 26
            radius: 13
            color: down ? "#cccccc" : "#ffffff"
            border.color: checked ? (down ? "#17a81a"
                                                          : "#21be2b")
                                            : "#999999"
        }
    }

    contentItem: Text {
        padding: 10
        text: checked ? qsTr("Темная тема") : qsTr("Светлая тема")
        font.pixelSize: Style.mediumFontSize
        // Mouse Press Control.Down
        color: down ? Style.secondaryTextColor : Style.primaryTextColor
        verticalAlignment: Text.AlignVCenter
        anchors.left: indicator.right
    }
}
