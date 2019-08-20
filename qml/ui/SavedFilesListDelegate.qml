import QtQuick 2.4

import Ubuntu.Components 1.3
import EdIt 1.0
import Ubuntu.Components.ListItems 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1


/* Delegate object used to display a locally saved object */
ListItem {
    id: standardItem
    width: localFilePickerPage.width
    anchors.horizontalCenter: parent.Center

    Label {
         id:placeholderLabel
          text: i18n.tr(" ")   /* placeholder */
          anchors {
                //right: placeholderLabel.left
                leftMargin: units.gu(2)
                rightMargin: units.gu(2)
                verticalCenter: parent.verticalCenter
          }
    }

    Label {
        id: fileLabel
        verticalAlignment: Text.AlignVCenter
        text: "<b>"+file+"</b>"
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
                   localFilePickerPage.selectedFileIndex = index
                   PopupUtils.open(confirmDeleteFileDialog)

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
                       var targetFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath + file;
                       //console.log("Full path file to open: "+targetFileName)

                       textArea.text = fileIO.read(targetFileName);
                       mainPage.title = fileIO.getFullName(targetFileName);
                       mainPage.saved = true /* ie: file NOT modified yet */
                       mainPage.openedFileName = file;
                       mainPage.currentFileLabelVisible = true

                       mainPage.pageStack.pop();
                   }
               },

               Action {
                   iconName: "info"
                   onTriggered: {
                       /* full path at the file */
                       var targetFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath + file;
                       var fileSize = fileIO.getSize(targetFileName); /* bytes */
                       var lastModifiedDate = fileIO.getFileLastModified(targetFileName);

                       localFilePickerPage.selectedFileModificationDate = lastModifiedDate;
                       localFilePickerPage.selectedFileSize = fileSize;
                       PopupUtils.open(fileInfoPopUp);
                   }
               }
         ]
    }

}
