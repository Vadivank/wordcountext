import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


import ControlsModule.Base 1.0
import StyleSettings 1.0

Item {
    property string text: "undefined"
    property bool checked: false

    Layout.topMargin: Style.spacingLarge
    Layout.fillWidth: true
    Layout.preferredHeight: Style.heightSubjectViewMedium
    Layout.leftMargin: Style.spacingLarge
    Layout.rightMargin: Style.spacingLarge

    BaseSwitcher {
        checked: parent.checked
        anchors.fill: parent
        text: parent.text
        onCheckedChanged: {
            parent.checked = checked
        }
    }

}
