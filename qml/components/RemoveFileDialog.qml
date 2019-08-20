import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/*
   Ask user confirmation before remove from the filesystem the selected file
 */
Dialog {
        id: confirmDeleteFileDialog

        /* the selected file index position in the LisModel */
        property string imageListModelIndex;

        title: i18n.tr("Confirmation")
        text: i18n.tr("Are you sure you want to remove the selected file?")

        Rectangle {
            width: 180;
            height: 50

            Item{
                Column{
                    spacing: units.gu(1)

                    Row{
                        spacing: units.gu(1)

                        /* placeholder */
                        Rectangle {
                            color: "transparent"
                            width: units.gu(3)
                            height: units.gu(3)
                        }

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
                            color: UbuntuColors.red
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
                            }
                        }
                    }

                    Row{
                        anchors.horizontalCenter: parent.horizontalCenter
                        Label{
                            id: deleteOperationResult
                            font.bold: true
                        }
                    }
                }
            }
        }
}
