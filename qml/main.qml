import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

import StyleSettings 1.0
import ControlsModule.Impl 1.0
import ChartsModule.Impl 1.0


Window {
    width: 1000
    minimumWidth: 350

    height: 600
    minimumHeight: 450

    visible: true

    color: Style.primaryBackgroundColor

    RowLayout {
        anchors.fill: parent
        spacing: 0
        ControlsView {
            Layout.minimumWidth: 200
            Layout.maximumWidth: 250
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        PlotView {
            Layout.minimumWidth: 150
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
