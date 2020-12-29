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
            text: "" //root.openedFileName
            inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(0.5)

            Label {
               text: i18n.tr("Save as encrypted file")
            }
            CheckBox {
                id: enableEncryptionCheckBox
                checked: false
                onCheckedChanged: {
                      /* to have mutual exclusion */
                      if(checked){
                          encryptionPasswordText.enabled = true
                      }else{
                          encryptionPasswordText.enabled = false
                      }
                }
            }
        }

        Row {
            TextField {
                id:encryptionPasswordText
                width: saveButton.width
                enabled: false
                placeholderText: i18n.tr("Encryption password")
                inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
            }
        }

        Button {
            id: saveButton
            text: i18n.tr("Save")
            color: UbuntuColors.green

            onClicked: {
                PopupUtils.close(dialogue)
                /* eg: newFileName: file:///tmp/.local/share/tedit.fulvio/due
                  console.log("fileIO.getHomePath():"+fileIO.getHomePath());
                */

                var newFileName;
                var contentToSave;

                if(enableEncryptionCheckBox.checked){  /* save as encrypted */
                    //console.log("Saving As encrypetd with pw: "+encryptionPasswordText.text)
                    contentToSave = encrypt(textArea.text, encryptionPasswordText.text);
                    /* append XXX suffix to file name */
                    newFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath+fileName.text+"-XXX";
                    mainPage.fileEncrypted = true;
                    mainPage.encryptionPassword = encryptionPasswordText.text;

                }else{  /* save as plain text */
                   //console.log("Saving As NOT encrypetd")
                   contentToSave = textArea.text;
                   newFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath+fileName.text;
                   mainPage.encryptionPassword = "";
                   mainPage.fileEncrypted = false;
                }

                if(!fileIO.write(newFileName, contentToSave)) {
                    showInfo(i18n.tr("Couldn't write"));
                } else {
                    showInfo(i18n.tr("Saved")); /* show an alert poup */
                    mainPage.saved = true;
                    mainPage.openedFileName = fileIO.getFullName(newFileName)
                    mainPage.title = mainPage.openedFileName //fileIO.getFullName(newFileName) /* file name without path */
                    mainPage.currentFileLabelVisible = true

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
