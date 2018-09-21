import QtQuick 2.4

import Ubuntu.Components 1.3

import Ubuntu.Components.ListItems 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1


/* Delgate object used to display a locally saved object */
ListItem {
    id: standardItem
    width: localFilePage.width  

    Label {
        id: label
        verticalAlignment: Text.AlignVCenter
        text: "<b>"+file+"</b>"+"     (Size: "+size + " bytes)"
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        id: selectableMouseArea
        anchors.fill: parent
        onClicked: {
            /* move the highlight component to the currently selected item */
            ubuntuListView.currentIndex = index
        }
    }

    /* Swipe to right movement: delete file */
    leadingActions: ListItemActions {
        actions: [
           Action {
               iconName: "delete"
               onTriggered: {
                 ubuntuListView.currentIndex = index
                 var fileToDelete = localFileslistModel.get(index).file; /* without path */
                 localFileslistModel.remove(index);

                 if(mainPage.title === fileToDelete) { /* the file to delete is the one currently saved */
                    //console.log("Removing opened file...")
                    mainPage.saved = false
                    textArea.text = ""
                    mainPage.title = "edit"
                    mainPage.openedFileName = "";
                 }

                 fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + fileToDelete)
               }
           }
        ]
     }

    /* Swipe to right movement: edit file */
    trailingActions: ListItemActions {
         actions: [
               Action {
                   iconName: "edit"
                   onTriggered: {
                       //console.log("Selected file to open: "+fileName)
                       var targetFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath + file;
                       textArea.text = fileIO.read(targetFileName);
                       mainPage.title = fileIO.getFullName(targetFileName);
                       mainPage.saved = true /* ie: file NOT modified yet */
                       mainPage.openedFileName = file;
                       mainPage.currentFileLabelVisible = true

                       mainPage.pageStack.pop();
                   }
               }
         ]
    }

}
