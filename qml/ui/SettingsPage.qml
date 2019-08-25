import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0

/*
  Application settings pages about font and colours
*/
Page {
     id: settingsPage

     header: PageHeader {
       title: i18n.tr("Settings")
     }
     visible: false

     property var target

     Column {
        anchors.fill: parent
        visible: parent.visible        

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

        ListItem.Standard {
              Label {
                  text: i18n.tr("Notes Area Font color")
                  font.bold: true
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.topMargin: units.gu(1)
              }
        }

        ColorListItem {
           label: i18n.tr("Green")
           itemColor: UbuntuColors.green
           onClicked: {
               settings.textAreaFontColor = itemColor
               textArea.color = itemColor
               pageStack.pop()
           }
       }

       ColorListItem {
          label: i18n.tr("Grey")
          itemColor: UbuntuColors.lightGrey
          onClicked: {
              settings.textAreaFontColor = itemColor
              textArea.color = itemColor
              pageStack.pop()
          }
      }

      ColorListItem {
         label: i18n.tr("Black")
         itemColor: UbuntuColors.black
         onClicked: {
             settings.textAreaFontColor = itemColor
             textArea.color = itemColor
             pageStack.pop()
         }
      }

      /* ------------ Application background colors -------------- */

      ListItem.Standard {
            Label {
                text: i18n.tr("Application Backgroung color")
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: units.gu(1)
            }
      }

      ColorListItem {
         label: i18n.tr("Green")
         itemColor: '#126381'
         onClicked: {
             settings.pageBackgroundColor = itemColor
             root.backgroundColor = itemColor
             pageStack.pop()
         }
      }

      ColorListItem {
         label: i18n.tr("Brown")
         itemColor: '#8F4B0E'
         onClicked: {
             settings.pageBackgroundColor = itemColor
             root.backgroundColor = itemColor
             pageStack.pop()
         }
      }

      ColorListItem {
         label: i18n.tr("White")  /* Default */
         itemColor:"white"
         onClicked: {
             settings.pageBackgroundColor = itemColor
             root.backgroundColor = itemColor
             pageStack.pop()
         }
      }

      ColorListItem {
         label: i18n.tr("Blue")
         itemColor: '#1E2F3F'
         onClicked: {
             settings.pageBackgroundColor = itemColor
             root.backgroundColor = itemColor
             pageStack.pop()
         }
      }


      ListItem.Standard {
            text: i18n.tr("Notes font size")+": "+textArea.font.pixelSize
            control: Slider {
                id: slider
                width: settingsPage.width/2
                function formatValue(v) { return v.toFixed(1) }
                minimumValue: 1
                maximumValue: 50
                value: settings.pixelSize
                live: false
                onValueChanged: {
                   textArea.font.pixelSize = formatValue(value) * 1
                   settings.pixelSize = formatValue(value) * 1
                }
            }
        }
    }
}
