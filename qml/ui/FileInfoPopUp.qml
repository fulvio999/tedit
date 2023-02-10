import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3


/*
   General info about the selected saved file
 */
Dialog {
       id: fileInfoDialog
       contentWidth: units.gu(45)
       title: i18n.tr("File Info")

       Label{
           text: i18n.tr("File Size")+": " +  localFilePickerPage.selectedFileSize +" bytes"
       }

       Label{
           text: i18n.tr("Modified")+": "+localFilePickerPage.selectedFileModificationDate
       }
       Label{
           text: i18n.tr("Time format (UTC): 'yyyy-mm-dd-HH:mm:ss'")
       }

       Button {
           text:  i18n.tr("Close")
           onClicked: PopupUtils.close(fileInfoDialog)
       }
}
