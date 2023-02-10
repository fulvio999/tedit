import QtQuick 2.4
import Lomiri.Components 1.3

Button {
    id: root_clickyicon

    /* passed as input when this custom component is used */
    property alias iconname: icon.name
    property alias iconcolor: icon.color
    property alias iconsource: icon.source

    color: "transparent"
    width: icon.width
    height: icon.height

    Icon {
        id: icon
        height: units.gu(3)
        width: units.gu(3)
        anchors.centerIn: parent
    }
}
