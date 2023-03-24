import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import EdIt 1.0

/*
   Ask for the encryption key to decrypt a file
 */
Dialog {
        id: decryptKeyInputDialogue
        title: i18n.tr("Entrer decrypt key")
        contentWidth: root.width - units.gu(5)

        /* the selected file index position in the ListModel */
        property string fileListModelIndex;

        Column{
                id: pageColumn
                spacing: units.gu(1.5)

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    TextField{
                       id:decryptionKey
                       width: decryptKeyInputDialogue.width - units.gu(8)
                       placeholderText: i18n.tr("Decryption key")
                       hasClearButton: true
                       inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                    }
                }

                Row{
                   anchors.horizontalCenter: parent.horizontalCenter
                   spacing: units.gu(1)

                   Button {
                       text: i18n.tr("Close")
                       width: units.gu(14)
                       onClicked: PopupUtils.close(decryptKeyInputDialogue)
                   }

                   Button {
                       text: i18n.tr("Confirm")
                       color: LomiriColors.green
                       width: units.gu(17)
                       onClicked: {

                             var targetFileName = localFileslistModel.get(fileListModelIndex).file; /* fileName without path */
                             //console.log("File name to decrypt: "+targetFileName);
                             var encryptedContent = fileIO.read(fileIO.getHomePath() + root.fileSavingPath + targetFileName).toString();
                             var decriptedText = decrypt(encryptedContent, decryptionKey.text);

                             if(decriptedText == ''){
                                messageLabel.text = i18n.tr("Wrong Password");
                                messageLabel.color = LomiriColors.red;

                             }else{
                                 textArea.text = decriptedText;
                                 mainPage.title = fileIO.getFullName(targetFileName);
                                 mainPage.saved = true  /* ie: file is NOT modified yet */
                                 mainPage.openedFileName = targetFileName;
                                 mainPage.currentFileLabelVisible = true
                                 mainPage.fileEncrypted = "Encrypted";
                                 mainPage.encryptionPassword = decryptionKey.text;

                                 PopupUtils.close(decryptKeyInputDialogue)
                                 mainPage.pageStack.pop();
                              }
                          }
                       }
                   }

                   Row {
                       anchors.horizontalCenter: parent.horizontalCenter
                       spacing: units.gu(1)
                       Label{
                          id: messageLabel
                          text:" "
                       }
                   }
              }
}
