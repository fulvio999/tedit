import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/*
   Popup shown when the user choose "Save" or "Save as" menu entry
*/
Dialog {
        id: dialogue
        title: i18n.tr("Save as")
        text: i18n.tr("Enter a name for the file to save.")

        Component.onCompleted: fileName.forceActiveFocus()

        TextField {
            id: fileName
            text: mainPage.openedFileName
            inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        }

        Button {
            text: i18n.tr("Save")
            color: UbuntuColors.green
            onClicked: {
                PopupUtils.close(dialogue)
                //eg: newFileName: file:///tmp/.local/share/tedit.fulvio/due
                console.log("fileIO.getHomePath():"+fileIO.getHomePath()); //  /tmp
                var newFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath+fileName.text;
                console.log("FileName to save: "+newFileName +" textArea content: "+textArea.text);

                if(!fileIO.write(newFileName, textArea.text)) {
                    showInfo(i18n.tr("Couldn't write"));
                } else {
                    showInfo(i18n.tr("Saved")); /* show an alert poup */
                    mainPage.saved = true;
                    mainPage.openedFileName = fileIO.getFullName(newFileName)
                    mainPage.title = mainPage.openedFileName //fileIO.getFullName(newFileName) /* file name without path */
                }
            }
        }

        Button {
            text: i18n.tr("Cancel")
            color: UbuntuColors.red
            onClicked: {
                PopupUtils.close(dialogue)
            }
        }
 }
