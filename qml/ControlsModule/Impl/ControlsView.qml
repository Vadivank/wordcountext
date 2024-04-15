import QtQuick 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1

import ControlsModule.Base 1.0
import StyleSettings 1.0

import QtQuick.Controls 2.12

BaseControlsField {

    property string fileName: ""

    DelegateSwitcher {
        onCheckedChanged: {
            Style.isDarkTheme = checked
        }
        text: checked ? qsTr("Темная тема") : qsTr("Светлая тема")
        checked: true
    }

    DelegateButton {
        text: qsTr("Открыть")
        onPressed: fileDialog.open()

    }

    DelegateButton {
        text: qsTr("Старт")
        onPressed: {
            fileName.length ? provider.start(parent.fileName) : {}
        }
    }

    DelegateButton {
        text: qsTr("Пауза")
        onPressed: {
            provider.pause()
        }
    }

    DelegateButton {
        text: qsTr("Отмена")
        onPressed: {
            fileName = ""
            provider.cancel()
        }
    }

    Text {
        Layout.fillWidth: true
        Layout.topMargin: Style.spacingLarge
        Layout.leftMargin: Style.spacingLarge
        Layout.rightMargin: Style.spacingLarge
        height: Style.heightSubjectViewLarge
        wrapMode: Text.Wrap
        font: Style.fontFamilyCourier
        color: Style.primaryTextColor
        text: parent.fileName
    }

    Item { // plug layout
        Layout.fillHeight: true
    }

    DelegateProgressBar {
        value: myDataModel.progressLoading
    }

    DelegateFileDialog {
        id: fileDialog
        onAccepted: {
            fileName = cleanPath(fileDialog.fileUrl);
        }
    }

}
