import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1

/*
  Page that list all the loacally saved files.
  Allow to delete a file with a Swipe movemet to the left, or open it by selecting a list item
*/
Page {
     id: localFilePage
     visible: false

     /* the list of locally saved files */
     ListModel {
        id: localFileslistModel
     }

     /*
      Ask confirm before remove all locally saved files
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
                      text:  i18n.tr("Delete")
                      color: UbuntuColors.red
                      width: units.gu(14)
                      onClicked: {
                            var fileList = fileIO.getLocalFileList(fileIO.getHomePath() + root.fileSavingPath);
                            for(var i=0; i<fileList.length; i++) {
                                fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + fileList[i])
                                //console.log("Deleting fileName: "+fileList[i]);
                                localFileslistModel.clear();
                            }
                            /* restore as first time use */
                            mainPage.title = i18n.tr('tedit')
                            mainPage.saved = true /* ie: file NOT modified yet */
                            mainPage.openedFileName = "";
                            textArea.text = "";

                            PopupUtils.close(confirmDialogue)
                      }
                  }
              }
         }
    }

     header: PageHeader {
          id: header
          title : i18n.tr("Local files saved")+": "+ localFileslistModel.count
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


     /* when the page become active, load the locally saved files */
     onActiveChanged: {
        if(active) {
            var fileList = fileIO.getLocalFileList(fileIO.getHomePath() + root.fileSavingPath)
            localFileslistModel.clear();
            for(var i=0; i<fileList.length; i++) {
               localFileslistModel.append({"file": fileList[i]});
            }
        }
    }

    /* show the list of locally saved files (the folder is the App one, due to apps confinement) */
    UbuntuListView {
        id: ubuntuListView
        anchors.fill: parent
        anchors.topMargin: units.gu(7) /* amount of space from the above component */

        Action {
            property string fileName
            id: closeAction
            /* an item is selected: open it in the textArea */
            onTriggered: {
                console.log("chosen file to open: "+fileName)
                var targetFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath + fileName;
                textArea.text = fileIO.read(targetFileName);
                mainPage.title = fileIO.getFullName(targetFileName);
                mainPage.saved = true /* ie: file NOT modified yet */
                mainPage.openedFileName = fileName;
            }
        }

        model: localFileslistModel
        delegate: ListItem.Standard {
            id: standardItem
            text: modelData
            removable: true
            confirmRemoval: true
            backgroundIndicator: Rectangle {
                anchors.fill: parent
                color: UbuntuColors.red
                Icon {
                    id: deleteIcon
                    name: "delete"
                    color: "white"
                    height: parent.height - units.gu(1)
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: standardItem.width/4 - width/2
                }
                Text {
                    text: i18n.tr("Remove")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: deleteIcon.right
                    color: "white"
                    font.bold: true
                }
            }

            onClicked: {
                    console.log("Opening local file name: "+file)
                    closeAction.fileName = file
                    mainPage.pageStack.pop();

                    /* if currently loaded file NOT saved propose 'Save as' dialog */
                    if(!mainPage.saved) {
                        unsavedDialog.closeAction = closeAction
                        PopupUtils.open(unsavedDialog)
                    } else{
                        closeAction.trigger()
                    }
            }

            onItemRemoved: { /* swipe to right and selected the Trash icon */
                //console.log("Removing local file name: "+file)
                fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + file)

                if(mainPage.title == text) { /* the file is the one currently saved */
                   mainPage.saved = false
                   textArea.text = ""
                   mainPage.title = "edit"
                   mainPage.openedFileName = "";
                }
            }
        }
    }

}
