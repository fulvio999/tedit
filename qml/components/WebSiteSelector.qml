import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3

import "../js/SiteImporter.js" as SiteImporter


/*
   Ask for a web site url where import is text and place in the text Area
 */
Dialog {
        id: importDialogue
        title: i18n.tr("Import a site as text")
        contentWidth: root. width - units.gu(5)

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
                       text: i18n.tr("Import")
                       color: LomiriColors.green
                       width: units.gu(17)
                       onClicked: {
                          if(webSiteUrlText.text !==""){
                             SiteImporter.importSiteText(webSiteUrlText.text);
                          }
                       }
                   }
              }

       } //col
}
