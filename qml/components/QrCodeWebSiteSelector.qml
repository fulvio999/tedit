import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/* import folder */
import "../ui"

/*
   Ask for a web site url to generate the corresponding QR Code
*/
Dialog {
        id: importDialogue
        title: i18n.tr("Generate QR Code")
        contentWidth: root.width - units.gu(5)

        Column{
                id: myDoctorPageColumn
                spacing: units.gu(1.5)

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    TextField{
                       id:webSiteUrlText
                       width: importDialogue.width - units.gu(8)
                       text: ""
                       placeholderText: i18n.tr("A valid http(s) url")
                       hasClearButton: false
                       inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                    }
                }

                Row{
                   anchors.horizontalCenter: parent.horizontalCenter
                   spacing: units.gu(1)

                   Button {
                       text: i18n.tr("Close")
                       width: units.gu(14)
                       onClicked: PopupUtils.close(importDialogue)
                   }

                   Button {
                       text: i18n.tr("Generate")
                       color: UbuntuColors.green
                       width: units.gu(17)
                       onClicked: {
                          if(webSiteUrlText.text !==""){
                              PopupUtils.close(importDialogue)
                              pageStack.push(Qt.resolvedUrl("../ui/QrCodeGeneratorPage.qml"),
                              {
                                  /* <pag-variable-name>:<property-value from db> */
                                  pageUrl: webSiteUrlText.text
                              }

                            );
                          }
                       }
                   }
              }

       } //col
}
