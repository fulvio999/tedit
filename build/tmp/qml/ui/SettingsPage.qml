import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0

Page {

     header: PageHeader {
       title: i18n.tr("Settings")
     }
     visible: false

     Column {
        anchors.fill: parent
        visible: parent.visible

        //placeholder
        Rectangle{
             color: "transparent"
             width: parent.width
             height: units.gu(8)
        }

        ListItem.Standard {
            text: i18n.tr("Enable text prediction")
            control: Switch {
                id: pred
                checked: settings.textPrediction
                text: i18n.tr("Text prediction")
                onCheckedChanged: {
                    settings.textPrediction = checked
                    if(checked)
                        textArea.inputMethodHints = Qt.ImhMultiLine
                    else
                        textArea.inputMethodHints = Qt.ImhMultiLine | Qt.ImhNoPredictiveText
                }
            }
            onClicked: pred.checked = !pred.checked
        }

        /*
        ListItem.Standard {
            control: Slider {
                id: slider
                width: parent.parent.width - units.gu(4)
                function formatValue(v) { return v.toFixed(1) }
                minimumValue: 0.5
                maximumValue: 5
                value: settings.fadingTime / 1000
                live: false
                onValueChanged: settings.fadingTime = formatValue(value) * 1000
            }
        }
        */
    }
}
