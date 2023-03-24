import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3

/*
   Ask user confirmation before remove from the filesystem the selected file
 */
Dialog {
        id: confirmDeleteFileDialog

        /* the selected file index position in the ListModel */
        property string imageListModelIndex;

        title: i18n.tr("Confirmation")
        text: i18n.tr("Remove")+" "+localFileslistModel.get(imageListModelIndex).file +" "+i18n.tr("file")+ " ?"

        Row{
            anchors.horizontalCenter: confirmDeleteFileDialog.Center
            spacing: units.gu(2)

            Button {
                id: closeButton
                text: i18n.tr("Close")
                width: units.gu(12)
                onClicked: PopupUtils.close(confirmDeleteFileDialog)
            }

            Button {
                    id: removeButton
                    width: units.gu(12)
                    text: i18n.tr("Remove")
                    color: LomiriColors.red
                    onClicked: {

                  			    var fileToDelete = localFileslistModel.get(imageListModelIndex).file; /* without path */
                  			    localFileslistModel.remove(imageListModelIndex);

                  					if(mainPage.title === fileToDelete) { /* the file to delete is the one currently saved */
                        				 mainPage.saved = false
                        				 textArea.text = ""
                    					   mainPage.openedFileName = "";
                      					 mainPage.currentFileLabelVisible = false
                        		}

                        		fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + fileToDelete)

                            deleteOperationResult.text = i18n.tr("File successfully removed")
                            removeButton.enabled = false
                            removeButton.visible = false
                      }
                  }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                Label{
                    text: " "
                    id: deleteOperationResult
                    font.bold: true
                }
            }
    }
