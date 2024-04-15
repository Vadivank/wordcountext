import QtQuick 2.12
//import QtQuick.Window 2.12
//import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2

FileDialog {
    modality: Qt.WindowModal

    nameFilters: ["Txt files (*.txt)", "All files (*)"]

    selectedNameFilter: "Txt files (*.txt)"

    sidebarVisible: false
    selectExisting: true
    selectMultiple: false

    onRejected: {}
}
