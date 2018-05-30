import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3



/* Ask confirmation before clear Text Area content */
Dialog {
       id: confirmDialogue
       title: i18n.tr("Confirmation")
       text: i18n.tr("Clear All content ?")

      Row{
         spacing: units.gu(2)
         Button {
             text:  i18n.tr("Close")
             width: units.gu(14)
             onClicked: PopupUtils.close(confirmDialogue)
         }
         Button {
             text: i18n.tr("Confirm")
             color: UbuntuColors.orange
             width: units.gu(14)
             onClicked: textArea.text = "";
         }
      }
}
