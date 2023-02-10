import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3



/* Ask confirmation before paste in Text Area Clipboard content */
Dialog {
       id: confirmDialogue
       title: i18n.tr("Confirmation")
       text: i18n.tr("Insert Clipboard content ?")

      Row{
         spacing: units.gu(2)
         Button {
             text:  i18n.tr("Close")
             width: units.gu(14)
             onClicked: PopupUtils.close(confirmDialogue)
         }
         Button {
             text: i18n.tr("Confirm")
             width: units.gu(14)
             color: LomiriColors.orange
             onClicked: {
                textArea.paste(Clipboard.data.text);
                PopupUtils.close(confirmDialogue)
             }
         }
      }
}
