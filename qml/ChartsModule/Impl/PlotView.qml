import QtQuick 2.12
import QtQml 2.12
import ChartsModule.Base 1.0

import StyleSettings 1.0

BaseCharts {
    id: root

    property double onePoint: 1
    property int maxValue: 0

    ListView {
        anchors.fill: parent

        model: myDataModel

        interactive: false // use false to deactivate swipe

        delegate: DelegateBar {
            id: modelItem
            text: " " + MODEL_WORD + " [" + MODEL_COUNTER + "] "
            height: root.height / myDataModel.rowCount()
//            {
//                var h = root.height / myDataModel.rowCount();
//                if (h < Style.heightSubjectViewMedium) {
//                    parent.interactive = true
//                    return Style.heightSubjectViewMedium;
//                } else {
//                    parent.interactive = false
//                    return h;
//                }
//            }
            width: MODEL_COUNTER * root.width / myDataModel.maxValue
            color: MODEL_COLOR
        }
    }
}
