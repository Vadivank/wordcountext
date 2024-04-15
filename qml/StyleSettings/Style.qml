pragma Singleton
import QtQml 2.12

// colors: https://htmlcolorcodes.com/

QtObject {
    property bool isDarkTheme: true

    readonly property color primaryColor: isDarkTheme ? "#BB86FC" : "#2FA8F9"
    readonly property color primaryVariantColor: "#3700B3"
    readonly property color secondaryColor: "#03DAC6"
    readonly property color secondaryVariant: isDarkTheme ? "#018786" : secondaryColor
    readonly property color errorColor: isDarkTheme ? "#CF6679" : "#B00020"
    readonly property color textColor: isDarkTheme ? "#FFFFFF" : "#000000"
    readonly property color themeDefaultColor: isDarkTheme ? "#000000" : "#FFFFFF"
    readonly property color themeInvertedColor: isDarkTheme ? "#FFFFFF" : "#000000"

    readonly property color progressBarColor: "#14E814"


    // font settings
    readonly property font primaryFont: Qt.font({
                                                    family: fontFamilyCourier,
                                                    pixelSize: mediumFontSize,
                                                    bold: false,
                                                    italic: false,
                                                    underline: false
                                                });

    readonly property font secondaryFont: Qt.font({
                                                    family: fontFamilyComicSans,
                                                    pixelSize: smallFontSize,
                                                    bold: false,
                                                    italic: false,
                                                    underline: false
                                                  });

    readonly property font headerFont: Qt.font({
                                                    family: fontFamilyArial,
                                                    pixelSize: largeFontSize,
                                                    bold: false,
                                                    italic: false,
                                                    underline: false
                                               });

    readonly property string fontFamilyCourier: "Courier"
    readonly property string fontFamilyLucida: "Lucida Console"
    readonly property string fontFamilyComicSans: "Comic Sans MS"
    readonly property string fontFamilyArial: "Arial"

    readonly property int littleFontSize: 10
    readonly property int smallFontSize: 12
    readonly property int mediumFontSize: 14
    readonly property int largeFontSize: 16



    // text color
    readonly property color primaryTextColor: isDarkTheme ? rgbWhite : rgbBlack
    readonly property color secondaryTextColor: isDarkTheme ? rgbHarborGray : rgbBlack
    readonly property color extreamallyTextColor: isDarkTheme ? rgbHarborGray : rgbHarborGray

    // tools color
    readonly property color primaryToolsColor: isDarkTheme ? rgbDarkOrange : rgbBlack
    readonly property color secondaryToolsColor: isDarkTheme ? rgbSteel : rgbBlack


    // background colors
    readonly property color primaryBackgroundColor: isDarkTheme ? rgbShadow : rgbPearlRiver
    readonly property color secondaryBackgroundColor: isDarkTheme ? rgbAnchor : rgbSteel

    // common colors
    readonly property color rgbWhite: "#FFFFFF"
    readonly property color rgbBlack: "#000000"
    readonly property color rgbRose: "#CF6679"
    readonly property color rgbWhine: "#B00020"

    // red tones
    readonly property color rgbIndianRed: "#CD5C5C"
    readonly property color rgbLightCoral: "#F08080"
    readonly property color rgbSalmon: "#FA8072"
    readonly property color rgbDarkSalmon: "#E9967A"
    readonly property color rgbCrimson: "#DC143C"
    readonly property color rgbRed: "#FF0000"
    readonly property color rgbFireBrick: "#B22222"
    readonly property color rgbDarkRed: "#8B0000"

    // pink tones
    readonly property color rgbPink: "#FFC0CB"
    readonly property color rgbLightPink: "#FFB6C1"
    readonly property color rgbHotPink: "#FF69B4"
    readonly property color rgbDeepPink: "#FF1493"
    readonly property color rgbMediumVioletRed: "#C71585"
    readonly property color rgbPaleVioletRed: "#DB7093"

    // orange tones
    readonly property color rgbLightSalmon: "#FFA07A"
    readonly property color rgbCoral: "#FF7F50"
    readonly property color rgbTomato: "#FF6347"
    readonly property color rgbOrangeRed: "#FF4500"
    readonly property color rgbDarkOrange: "#FF8C00"

    // green tones
    readonly property color rgbGreenYellow: "#ADFF2F"
    readonly property color rgbChartreuse: "#7FFF00"
    readonly property color rgbLawnGreen: "#7CFC00"
    readonly property color rgbLime: "#00FF00"
    readonly property color rgbLimeGreen: "#32CD32"
    readonly property color rgbPaleGreen: "#98FB98"
    readonly property color rgbLightGreen: "#90EE90"
    readonly property color rgbMediumSpringGreen: "#00FA9A"
    readonly property color rgbSpringGreen: "#00FF7F"
    readonly property color rgbMediumSeaGreen: "#3CB371"
    readonly property color rgbSeaGreen: "#2E8B57"
    readonly property color rgbForestGreen: "#228B22"
    readonly property color rgbGreen: "#008000"
    readonly property color rgbDarkGreen: "#006400"
    readonly property color rgbYellowGreen: "#9ACD32"
    readonly property color rgbOliveDrab: "#6B8E23"
    readonly property color rgbOlive: "#808000"
    readonly property color rgbDarkOliveGreen: "#556B2F"
    readonly property color rgbMediumAquamrine: "#66CDAA"
    readonly property color rgbDarkSeaGreen: "#8FBC8F"
    readonly property color rgbLightSeaGreen: "#20B2AA"
    readonly property color rgbDarkCyan: "#008B8B"
    readonly property color rgbTeal: "#008080"

    // yellow tones
    readonly property color rgbYellow: "#FFFF00"
    readonly property color rgbCornsilk: "#FFF8DC"
    readonly property color rgbBlanchedAlmond: "#FFEBCD"
    readonly property color rgbBisque: "#FFE4C4"
    readonly property color rgbNavajoWhite: "#FFDEAD"
    readonly property color rgbWheat: "#F5DEB3"
    readonly property color rgbBurlyWood: "#DEB887"
    readonly property color rgbTan: "#D2B48C"
    readonly property color rgbRosyBrown: "#BC8F8F"
    readonly property color rgbSandyBrown: "#F4A460"
    readonly property color rgbGoldenrod: "#DAA520"
    readonly property color rgbDarkGoldenRod: "#B8860B"
    readonly property color rgbPeru: "#CD853F"
    readonly property color rgbChocolate: "#D2691E"
    readonly property color rgbSaddleBrown: "#8B4513"
    readonly property color rgbSienna: "#A0522D"
    readonly property color rgbBrown: "#A52A2A"
    readonly property color rgbMaroon: "#800000"

    // blue tones
    readonly property color rgbAquaCyan: "#00FFFF"
    readonly property color rgbLightCyan: "#E0FFFF"
    readonly property color rgbPaleTurquose: "#AFEEEE"
    readonly property color rgbAquamarine: "#7FFFD4"
    readonly property color rgbTurquose: "#40E0D0"
    readonly property color rgbMediumTurquose: "#48D1CC"
    readonly property color rgbDarkTurquose: "#00CED1"
    readonly property color rgbCadetBlue: "#5F9Ea0"
    readonly property color rgbSteelBlue: "#4682B4"
    readonly property color rgbLightSteelBlue: "#B0C4DE"
    readonly property color rgbPowderBlue: "#B0E0E6"
    readonly property color rgbLightBlue: "#ADD8E6"
    readonly property color rgbSkyBlue: "#87CEEB"
    readonly property color rgbLightSkyBlue: "#87CEFA"
    readonly property color rgbDeepSkyBlue: "#00BFFF"
    readonly property color rgbDodgerBlue: "#1E90FF"
    readonly property color rgbComflowerBlue: "#6495ED"
    readonly property color rgbMediumStateBlue: "#7B68EE"
    readonly property color rgbRoyalBlue: "#4169E1"
    readonly property color rgbBlue: "#0000FF"
    readonly property color rgbMediumBlue: "#0000CD"
    readonly property color rgbDarkBlue: "#00008B"
    readonly property color rgbNavy: "#000080"
    readonly property color rgbMidnightBlue: "#191970"

    // gray tones
    readonly property color rgbGray: "#828282"
    readonly property color rgbFossil: "#787276"
    readonly property color rgbMink: "#88807B"
    readonly property color rgbPearlRiver: "#D9DDDC"
    readonly property color rgbAbalone: "#D6CFC7"
    readonly property color rgbHarborGray: "#C7C6C1"
    readonly property color rgbSmoke: "#BEBDB8"
    readonly property color rgbThunder: "#BDB7AB"
    readonly property color rgbPewter: "#999DA0"
    readonly property color rgbSteel: "#777B7E"
    readonly property color rgbStone: "#877F7D"
    readonly property color rgbIron: "#48494B"
    readonly property color rgbRhino: "#B9BBB6"
    readonly property color rgbTrout: "#97978F"
    readonly property color rgbSeal: "#818380"
    readonly property color rgbLava: "#808588"
    readonly property color rgbShadow: "#363636"
    readonly property color rgbAsh: "#544C4A"
    readonly property color rgbAnchor: "#3E424B"
    readonly property color rgbCharcoal: "#222021"


    readonly property real defaultOpacity: 1
    readonly property real emphasisOpacity: 0.87
    readonly property real secondaryOpacity: 0.6
    readonly property real disabledOpacity: 0.38

    readonly property int defaultOffset: 15
    readonly property int mediumOffset: 10
    readonly property int tinyOffset: 5

    // height of view element
    readonly property int heightSubjectViewSmall: 20
    readonly property int heightSubjectViewMedium: 25
    readonly property int heightSubjectViewBig: 35
    readonly property int heightSubjectViewLarge: 60

    readonly property real spacingNone: 1
    readonly property real spacingSmall: 5
    readonly property real spacingMedium: 10
    readonly property real spacingLarge: 20


}
