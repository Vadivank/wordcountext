import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import StyleSettings 1.0

ColumnLayout {
    spacing: Style.spacingSmall

    function cleanPath (dirtyFilename) {
        var path = dirtyFilename.toString();
        path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
        var cleanPath = decodeURIComponent(path);
        return cleanPath
    }
}
