import QtQuick 2.4
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3



/*
   Ask at the user if want save or not the current note before create a new one containing the provided
   Base64 encoded content
*/
Dialog {
       id: confirmSaveDialogue
       title: i18n.tr("Confirmation")
       text: i18n.tr("Previous note was modified, save it ?")

       /* Base64 encoded text to insert in the new created note */
       property string base64TextToInsert;

       Row{
         spacing: units.gu(2)

         /* user DON'T want save old note: create a new one  overwriting unsaved content */
         Button {
             text: i18n.tr("No")
             width: units.gu(14)
             onClicked: {

                /* reset flags */
                mainPage.saved = false;
                currentFileOpenedLabel.color = '#A40000'
                mainPage.openedFileName = ""
                mainPage.currentFileLabelVisible = false
                textArea.text = base64TextToInsert

                PopupUtils.close(confirmSaveDialogue)

                pageStack.push(mainPage)
             }
         }

         /* user want save note content and after create a new one */
         Button {
             text: i18n.tr("Yes")
             color: LomiriColors.orange
             width: units.gu(14)
             onClicked: {
                if(mainPage.openedFileName == "") {
                    //console.log("Note content was never saved (is new) show saving form");
                    saveRow.visible = true
                } else {
                    /* Note already created: just save it */
                    saveExistingFile(mainPage.openedFileName,fileIO.getHomePath() + root.fileSavingPath)

                    /* reset flags and set new note content at Base64 result */
                    mainPage.saved = true;
                    currentFileOpenedLabel.color = '#A40000'
                    mainPage.openedFileName = ""
                    mainPage.currentFileLabelVisible = false
                    
                    textArea.text = base64TextToInsert
                    PopupUtils.close(confirmSaveDialogue)
                    pageStack.pop(base64ConversionPage)
                }
             }
         }
    }

    /* shown if the user want save note currently content  */
    Row{
        id:saveRow
        visible: false
        spacing: units.gu(0.5)

        TextField {
            id: fileName
            placeholderText: i18n.tr("file name")
            inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        }

        Button {
            text: i18n.tr("ok")
            color: LomiriColors.green
            width: units.gu(7)
            onClicked: {

                  var newFileName = "file://" + fileIO.getHomePath() + root.fileSavingPath + fileName.text;

                  if(!fileIO.write(newFileName, textArea.text)) {
                      showInfo(i18n.tr("Couldn't write"));
                  } else {
                      showInfo(i18n.tr("Saved"));

                      /* reset flags and set new note content at Base64 result */
                      mainPage.saved = true;
                      currentFileOpenedLabel.color = '#A40000'
                      mainPage.openedFileName = ""
                      mainPage.currentFileLabelVisible = false
                      textArea.text = base64TextToInsert

                      PopupUtils.close(confirmSaveDialogue)

                      pageStack.pop(base64ConversionPage)
                      //pageStack.push(mainPage)
                  }
            }
        }
    }

}
