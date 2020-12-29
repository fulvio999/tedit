import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1
import "../components"

/*
  Page that list all the locally saved files.
  Allow to delete or open a file choosing the operation with a Swipe movement
*/
Page {
     id: localFilePickerPage
     visible: false

     /* info about the currently selected file in the listModel */
     property string selectedFileSize: ""
     property string selectedFileModificationDate: ""
     property string selectedFileIndex: ""

     Component {
         id: fileInfoPopUp
         FileInfoPopUp{}
     }

     Component {
         id: confirmDeleteFileDialog
         RemoveFileDialog{imageListModelIndex: localFilePickerPage.selectedFileIndex}
     }

     Component {
         id: decryptKeyInput
         DecryptKeyInput{fileListModelIndex: localFilePickerPage.selectedFileIndex}
     }

     /* the list of locally saved files */
     ListModel {
        id: localFileslistModel
     }

     /*
        Ask confirmation before remove all locally saved files
     */
     Component{
          id: confirmComponent
          Dialog {
              id: confirmDialogue
              title: i18n.tr("Attention")
              text: i18n.tr("Remove ALL saved files ? (No restore)")

              Row{
                  anchors.horizontalCenter: parent.horizontalCenter
                  spacing: units.gu(2)

                  Button {
                      text: i18n.tr("Close")
                      onClicked: PopupUtils.close(confirmDialogue)
                      width: units.gu(14)
                  }

                  Button {
                      id: removeButton
                      text:  i18n.tr("Delete")
                      color: UbuntuColors.red
                      width: units.gu(14)
                      onClicked: {
                            var fileList = fileIO.getLocalFileList(fileIO.getHomePath() + root.fileSavingPath);
                            for(var i=0; i<fileList.length; i++) {
                                fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + fileList[i])
                                /* console.log("Deleting file with name: "+fileList[i]); */
                                localFileslistModel.clear();
                            }
                            /* restore as first time use */
                            mainPage.saved = true /* ie: file NOT modified yet */
                            mainPage.openedFileName = "";
                            mainPage.currentFileLabelVisible = false;
                            textArea.text = "";

                            deleteOperationResult.text = i18n.tr("All Files successfully removed")
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
     }

     header: PageHeader {
          id: header
          title : i18n.tr("Local files")+": "+ localFileslistModel.count +"  "+ i18n.tr("(swipe for options)")
          trailingActionBar.actions: [

              Action {
                     id: deleteAll
                     text: i18n.tr("Delete all")
                     iconName: "delete"
                     onTriggered: {
                        PopupUtils.open(confirmComponent)
                     }
               }
         ]
    }

    /* when the page become active, load the locally saved files in the ListModel */
    onActiveChanged: {
         if(active) {
             var homePath = fileIO.getHomePath();
             var fileList = fileIO.getLocalFileList(homePath + root.fileSavingPath);
             localFileslistModel.clear();

             for(var i=0; i<fileList.length; i++) {
                 var targetFileName = "file://" + homePath + root.fileSavingPath + fileList[i];
                 var fileSize = fileIO.getSize(targetFileName); //bytes
                 var lastModifiedDate = fileIO.getFileLastModified(targetFileName);
                 localFileslistModel.append({"file": fileList[i]});
             }
         }
    }

    /* show the list of locally saved files in the App folder */
    UbuntuListView {
        id: ubuntuListView
        anchors.fill: parent
        anchors.topMargin: units.gu(6)
        model: localFileslistModel
        delegate: SavedFilesListDelegate{}
    }
}
