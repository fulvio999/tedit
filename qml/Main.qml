
import QtQuick 2.4
import Ubuntu.Components 1.3
import EdIt 1.0
import Ubuntu.Content 1.1
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import "components"
import "ui"

/* digest calculator functions */
import "js/hashes.js" as Hashes

import "js/base64.js" as Base64enc

MainView {

    id: root
    objectName: "mainView"

    /* Note! applicationName needs to match the "name" field of the click manifest */
    applicationName: "tedit.fulvio"
    property string appVersion : "1.9"

    /* application hidden folder where are saved the files. (path is fixed due to Appp confinement rules) */
    property string fileSavingPath: "/.local/share/tedit.fulvio/"

    automaticOrientation: true
    anchorToKeyboard: true

    //backgroundColor: UbuntuColors.blue

    /*------- Tablet (width >= 110) -------- */
    //vertical
    //width: units.gu(75)
    //height: units.gu(111)

    //horizontal (rel)
    width: units.gu(100)
    height: units.gu(75)

    /* ----- phone 4.5 (the smallest one) ---- */
    //vertical
    //width: units.gu(50)
    //height: units.gu(96)

    //horizontal
    //width: units.gu(96)
    //height: units.gu(50)
    /* -------------------------------------- */

    /*  the text to show in the operation result popUp*/
    property string infoText: ""

    Settings {
       id: settings
       /* by default disable autocomplete in text area */
       property bool textPrediction: false
    }

    /* To notify messages at the user */
    Component {
        id: popover
        Dialog {
            id: po
            text: "<b>"+infoText+"</b>"
            MouseArea {
                anchors.fill: parent
                onClicked: PopupUtils.close(po)
            }
        }
    }

    Component {
        id: confirmClearAll
        ConfirmClearAll{}
    }

    Component {
        id: confirmPasteFromClipboard
        ConfirmPasteFromClipboard{}
    }

    /* custom c++ plugin to save file on filesystem */
    FileIO {
       id: fileIO
    }

    /*
      Using custom plugin FileIO save the file in the App hidden folder
    */
    function saveExistingFile(filename, destinationDir) {

        //console.log("Saving exisitng filename: "+filename+ " to dir: "+destinationDir);
        /* path and fileName */
        var destinationFolder = "file://" + destinationDir + fileIO.getFullName(filename);
        //console.log("Destination folder and path: "+destinationFolder);

        /* dummy solution to prevent content append */
        if(fileIO.exists(destinationFolder)){
           //console.log("File already exist removing it....")
           fileIO.remove(destinationFolder)
        }
        fileIO.write(destinationFolder, textArea.text);
        showInfo(i18n.tr("Saved"));
        /* to prevent opening UnSavedDialog */
        mainPage.saved = true;
    }

    /* show a Popup containing the provided in argument input */
    function showInfo(info) {
        infoText = "\n" + info + "\n";
        PopupUtils.open(popover);
    }

    /* PopUp with the Application info */
    Component {
       id: productInfo
       ProductInfo{}
    }

    /* PopUp with the available Hash calculator */
    Component {
       id: digestCalculatorChooser
       DigestCalculator{inputText: textArea.text}
    }

    /* Ask for remote web-site url where import text to insert in the text area */
    Component {
       id: webSiteSelector
       WebSiteSelector{}
    }

    Component {
       id: saveAsDialog
       SaveAsDialog{}
    }

    SettingsPage {
       id: settingsPage
    }

    Base64conversionPage {
      id: base64conversionPage
    }

    LocalFilePicker {
       id: localFilePicker
    }

    UnsavedDialog  {
       id: unsavedDialog;
       property Action closeAction
    }

    /* the list of available digest calculator  (ie: the one supported by 'jshashes' library ) */
    ListModel{
        id: digesterCalculatorListModel

        ListElement {
           name: "MD5"
        }

        ListElement {
           name: "SHA-1"
        }

        ListElement {
           name: "SHA-512"
        }

        ListElement {
            name: "SHA-256"
        }

        ListElement {
            name: "RMD-160"
        }
    }

    /* renderer for the entry in the Digest OptionSelector */
    Component {
        id: digestChooserDelegate
        OptionSelectorDelegate {  text: name; }
    }

     PageStack {
        id: pageStack

        Component.onCompleted: {
           pageStack.push(mainPage)
        }

        /* APP main page */
        Page {
            id: mainPage
            anchors.fill: parent

            property Item textArea
            property bool saved: true /* a flag: true if file is NOT currently modified */
            property string openedFileName: ""  /* the currently opened file name */
            property bool currentFileLabelVisible: false /* to hide/show labe with the current file name */

            header: PageHeader {
                id: header
                title: i18n.tr("tedit")

                /* leadingActionBar is the bar on the left side */
                leadingActionBar.actions: [
                      Action {
                          id: aboutPopover
                          /* note: icons names are file names under: /usr/share/icons/suru/actions/scalable */
                          iconName: "info"
                          text: i18n.tr("About")
                          onTriggered:{
                             PopupUtils.open(productInfo)
                          }
                      },

                      Action {
                          id:settingsAction
                          text: i18n.tr("Settings")
                          iconName: "settings"
                          onTriggered: {
                              pageStack.push(settingsPage)
                              settingsPage.visible = true
                          }
                      }
                ]

                trailingActionBar.actions: [

                     Action {
                          id: importTextSite
                          text: i18n.tr("Import site text")
                          iconSource: Qt.resolvedUrl("./graphics/import.png")
                          onTriggered: {
                              PopupUtils.open(webSiteSelector);
                          }
                     },

                     Action {
                         id: undo
                         text: i18n.tr("Undo")
                         iconSource: Qt.resolvedUrl("./graphics/undo.png")
                         onTriggered: {
                            textArea.undo()
                         }
                     },

                     Action {
                         id: redo
                         text: i18n.tr("Redo")
                         iconSource: Qt.resolvedUrl("./graphics/redo.png")
                         onTriggered: {
                             textArea.redo()
                         }
                     },

                     /*
                       Clear TextArea current content
                     */
                     Action {
                         id: clearList
                         text: i18n.tr("Clear All")
                         iconSource: Qt.resolvedUrl("./graphics/clear.png")
                         onTriggered: {
                            PopupUtils.open(confirmClearAll)
                         }
                     },

                     /*
                       Paste in the textArea the clipboard content
                     */
                     Action {
                         id: importClipboard
                         text: i18n.tr("Paste from clipboard")
                         iconName: "edit-paste"
                         onTriggered: {
                            //textArea.paste(Clipboard.data.text);
                            PopupUtils.open(confirmPasteFromClipboard)
                         }
                     },

                     Action {
                         id: selectAll
                         text: i18n.tr("Select all")
                         iconName: "select"
                         onTriggered: {
                            textArea.selectAll();
                         }
                     },

                     Action {
                         id: copyToClipboard
                         text: i18n.tr("Copy to clipboard")
                         iconName: "edit-copy"
                         onTriggered: {
                            textArea.copy();
                         }
                     },

                     Action {
                         id:save
                         text: i18n.tr("Save")
                         iconSource: Qt.resolvedUrl("./graphics/save.png")
                         onTriggered: {
                             if(mainPage.openedFileName == "") { /* true if file is new, never saved  */
                                 //console.log("Saving a new file...")
                                 PopupUtils.open(saveAsDialog)
                             } else { /* file not new: already exist */
                                 //console.log("saving existing file...")
                                 saveExistingFile(mainPage.openedFileName,fileIO.getHomePath() + root.fileSavingPath)
                             }
                         }
                     },

                     Action {
                         id:saveAs
                         text: i18n.tr("Save as")
                         iconSource: Qt.resolvedUrl("./graphics/save-as.png")
                         onTriggered: {
                            PopupUtils.open(saveAsDialog)
                         }
                     },

                     Action {
                         id: reOpen
                         text: i18n.tr("Open saved file")
                         iconSource: Qt.resolvedUrl("./graphics/open.png")
                         onTriggered: {
                             pageStack.push(localFilePicker);
                         }
                     },

                     Action {
                         id: hashCalculator
                         iconSource: Qt.resolvedUrl("./graphics/digest.png")
                         text: i18n.tr("Digest")
                         onTriggered:{
                            PopupUtils.open(digestCalculatorChooser)
                         }
                     },

                     Action {
                         id: base64Converter
                         iconSource: Qt.resolvedUrl("./graphics/base64.png")
                         text: i18n.tr("Base64")
                         onTriggered:{
                            pageStack.push(base64conversionPage);
                         }
                     }
               ]
         }

         Column {
             id: editCategoryPageLayout
             anchors.fill: parent
             spacing: units.gu(1)

             anchors {
                margins: units.gu(1)
             }

             /* placeholder */
             Rectangle{
                id: placeHolderRectangle
                color: "transparent"
                width: parent.width
                height: units.gu(4.5)
             }

             Rectangle{
                   id: currentFileOpenedContainer
                   color: "transparent"
                   width: parent.width
                   height: units.gu(3)

                   Label{
                      id: currentFileOpenedLabel
                      visible: mainPage.currentFileLabelVisible
                      anchors.verticalCenter: parent.verticalCenter
                      text: i18n.tr("File")+": "+mainPage.openedFileName+"     ("+i18n.tr("saved")+": "+ mainPage.saved+")"
                      font.bold: true
                   }
             }

             Rectangle{
                 id: textAreaContainer
                 width: parent.width
                 height: mainPage.height - placeHolderRectangle.height - currentFileOpenedContainer.height - units.gu(7)

                 /* Display the file content */
                 TextArea {
                      id: textArea
                      width: parent.width
                      height: parent.height
                      textFormat: TextEdit.AutoText
                      placeholderText: i18n.tr("Welcome ! Write what you want and save it. Enjoy !")
                      inputMethodHints: settings.textPrediction ? Qt.ImhMultiLine : Qt.ImhMultiLine | Qt.ImhNoPredictiveText
                      selectByMouse: true
                      onTextChanged: mainPage.saved = false; /* update flag file modified and not saved */
                      wrapMode: settings.wordWrap ? TextEdit.Wrap : TextEdit.NoWrap
                 }
             }

             Rectangle{
                 width: parent.width
                 height: units.gu(3)
                 Label{
                   text: i18n.tr("Line")+": "+textArea.lineCount+ "  "+ i18n.tr("Characters")+": "+textArea.length
                   font.bold: true
                 }
             }

          }

      } //mainPage page
   }
}
