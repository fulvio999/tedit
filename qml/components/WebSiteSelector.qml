import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../js/SiteImporter.js" as SiteImporter


/*
   Ask the web site url where import is text and place in the text Area
 */
Dialog {
        id: importDialogue
        title: i18n.tr("Import a site as text")

        Row{
            TextField{
               id:webSiteUrlText
               width: parent.width
               text: ""
               placeholderText: i18n.tr("A valid http(s) url")
               hasClearButton: false
            }
        }

        Row{
           spacing: units.gu(2)
           Button {
               text: i18n.tr("Close")
               width: units.gu(14)
               onClicked: PopupUtils.close(importDialogue)
           }
           Button {
               text: i18n.tr("Import")
               color: UbuntuColors.orange
               width: units.gu(14)
               onClicked: {
                  if(webSiteUrlText.text !==""){
                     SiteImporter.importSiteText(webSiteUrlText.text);
                  }
               }
           }
      }
}
