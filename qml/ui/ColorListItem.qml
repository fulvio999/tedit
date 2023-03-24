import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.ListItems 1.3 as ListItem


/*
   Item used in the SettingPage to provide color choice at the user
 */
ListItem.Standard {

    property string label

    property color itemColor

    id: listItem
    text: label
    control: LomiriShape {
        backgroundColor: itemColor
        width: units.gu(4)
        height: units.gu(4)
    }
}
