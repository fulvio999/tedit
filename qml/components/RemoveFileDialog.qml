import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Component {
    Dialog {
        id: dialogue
        title: i18n.tr("Remove file")
        text: i18n.tr("Are you sure you want to remove the selected file?")
        Button {
            text: i18n.tr("Yes")
            color: UbuntuColors.green
            onClicked: {
                fileIO.remove(fileIO.getHomePath() + root.fileSavingPath + localFilePicker.fileName)

                if(root.title == localFilePicker.fileName)
                    root.saved = false

                localFilePicker.fileList.remove(localFilePicker.fileIndex)
                localFilePicker.fileName = ""
                localFilePicker.fileIndex = -1

                PopupUtils.close(dialogue)
            }
        }
        Button {
            text: i18n.tr("No")
            color: UbuntuColors.red
            onClicked: {
                PopupUtils.close(dialogue)
            }
        }
    }
}
