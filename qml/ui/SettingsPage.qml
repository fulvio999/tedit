import QtQuick 2.4
import Ubuntu.Components 1.3
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

     Flickable {
          id: settingsPageFlickable
          clip: true
          contentHeight: units.gu(90)
          anchors {
                  top: parent.top
                  left: parent.left
                  right: parent.right
                  bottom: settingsPage.bottom
                  bottomMargin: units.gu(1)
         }

         Column {
            id: settingsColumn
            anchors.fill: parent
            visible: parent.visible

            /* placeholder */
            Rectangle {
                color: "transparent"
                width: parent.width
                height: units.gu(5)
            }

            ListItem {

                Label {
                    id:enableWordWrapLabel
                    text: i18n.tr("Enable Word wrap")
                    anchors {
                        leftMargin: units.gu(2)
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                 }

                 Switch {
                        id: wrap
                        checked: settings.wordWrap
                        text: i18n.tr("Word wrap")
                        onCheckedChanged: {
                            settings.wordWrap = checked
                            if(checked)
                               textArea.wrapMode = TextEdit.Wrap
                            else
                               textArea.wrapMode = TextEdit.NoWrap
                       }

                       anchors {
                            leftMargin: units.gu(3)
                            left: fontLabel.right
                            rightMargin: units.gu(2)
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                       }
                  }
               onClicked: wrap.checked = !wrap.checked
            }

            ListItem {
                 Label {
                       id:enablePredictionLabel
                       text: i18n.tr("Enable text prediction")
                       anchors {
                           leftMargin: units.gu(2)
                           left: parent.left
                           verticalCenter: parent.verticalCenter
                       }
                  }

                Switch {
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

                    anchors {
                          leftMargin: units.gu(3)
                          left: fontLabel.right
                          rightMargin: units.gu(2)
                          right: parent.right
                          verticalCenter: parent.verticalCenter
                    }

                }

                onClicked: pred.checked = !pred.checked

            }

            ListItem {
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

          ListItem {
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
             id:blueColorChooser
             label: i18n.tr("Blue")
             itemColor: '#1E2F3F'
             onClicked: {
                 settings.pageBackgroundColor = itemColor
                 root.backgroundColor = itemColor
                 pageStack.pop()
             }
          }

          ListItem {
                id:fontContainer
                divider.visible : false
                height: units.gu(12)
                Label {
                    id:fontLabel
                    text: i18n.tr("Notes font size")+": "+textArea.font.pixelSize
                    anchors {
                        leftMargin: units.gu(2)
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                }

                Slider {
                    id: slider
                    function formatValue(v) { return v.toFixed(1) }
                    minimumValue: 20
                    maximumValue: 80
                    value: settings.pixelSize
                    live: false
                    onValueChanged: {
                       textArea.font.pixelSize = formatValue(value) * 1
                       settings.pixelSize = formatValue(value) * 1
                    }

                    anchors {
                          leftMargin: units.gu(3)
                          left: fontLabel.right
                          rightMargin: units.gu(2)
                          right: parent.right
                          verticalCenter: parent.verticalCenter
                    }
                }
            }

        } //col

  } //Flickable

  Scrollbar {
       flickableItem: settingsPageFlickable
       align: Qt.AlignTrailing
  }

}
