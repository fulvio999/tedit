
import QtQuick 2.4
import Ubuntu.Components 1.3
import EdIt 1.0
import Ubuntu.Content 1.1
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import "components"
import "ui"

import Ubuntu.Components.ListItems 1.3 as ListItem

/* digest calculator functions */
import "js/hashes.js" as Hashes
import "js/base64.js" as Base64enc

/* Crypto lib for file protection */
import "js/crypto-js/crypto-js.js" as CryptoJSLib

import "js/Utility.js" as Utility


MainView {

    id: root
    objectName: "mainView"

    /* Note! applicationName needs to match the "name" field of the click manifest */
    applicationName: "tedit.fulvio"
    property string appVersion : "2.8.1"

    /* application hidden folder where are saved the files. (path is fixed due to Appp confinement rules) */
    property string fileSavingPath: "/.local/share/tedit.fulvio/"

    automaticOrientation: true
    anchorToKeyboard: true

    /* enable to test with dark theme */
    //theme.name: "Ubuntu.Components.Themes.SuruDark"

    /*------- Tablet (width >= 110) -------- */
    //vertical
    //width: units.gu(75)
    //height: units.gu(111)

    //horizontal (for release)
    width: units.gu(100)
    height: units.gu(75)

    /* ----- phone 4.5 (the smallest one) ---- */
    //vertical
    //width: units.gu(50)
    //height: units.gu(72)

    //horizontal
    //width: units.gu(96)
    //height: units.gu(50)
    /* -------------------------------------- */

    /* the text to show in the operation result popUp */
    property string infoText: ""

    Settings {
       id: settings
       /* by default disable autocomplete in text area */
       property bool textPrediction: false
       property bool wordWrap: false
       property string showAlert: "true"
       property string pageBackgroundColor: "white"
       property string textAreaFontColor: "black"
       property int pixelSize: 20 /* default */
    }

    Component.onCompleted: {
        root.backgroundColor = settings.pageBackgroundColor

        if(settings.showAlert == "true"){
           showInfo(i18n.tr("Before use encryption feature")+"<br>"+i18n.tr("read help page clicking on pencil icon in the upper right corner"));
           settings.showAlert = "false"
        }
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

    /* Menu Chooser */
    Component {
        id: menuPopover
        Dialog {
            id: menuDialog
            text: "<b>"+infoText+"</b>"
            MouseArea {
                anchors.fill: parent
                onClicked: PopupUtils.close(menuDialog)
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

    /* custom C++ plugin to save/manage files on the filesystem */
    FileIO {
       id: fileIO
    }

    /*
      Encrypt the provided content using the provided key
    */
    function encrypt(content, key) {
        var iv= '16BytesLengthKey';
        var CryptoJS = CryptoJSLib.CryptoJS;
        var AES = CryptoJS.AES;
        var ivStr  = CryptoJS.enc.Utf8.parse(iv);
        var keyStr = CryptoJS.enc.Utf8.parse(key);

        var text = AES.encrypt(content, keyStr, {
                                   iv: ivStr,
                                   mode: CryptoJS.mode.OFB,
                                   padding: CryptoJS.pad.Iso10126
                               });
        return text.toString();
    }

    /*
      DEcrypt the provided ciphertext using the provided key
    */
    function decrypt(ciphertext, key) {
          var iv= '16BytesLengthKey';
          var CryptoJS = CryptoJSLib.CryptoJS;
          var AES = CryptoJS.AES;
          var ivStr  = CryptoJS.enc.Utf8.parse(iv);
          var keyStr = CryptoJS.enc.Utf8.parse(key);

          /* Note: decrypt works only with this values of 'mode' and 'padding' */
          var bytes = AES.decrypt(ciphertext, keyStr, {
                                      iv: ivStr,
                                      mode: CryptoJS.mode.OFB,
                                      padding: CryptoJS.pad.Iso10126
                                  });

          var plaintext = bytes.toString(CryptoJS.enc.Utf8);

          return plaintext.toString();
    }

    /*
       Used when the user press "Save" button in the menu for an already saved file
       whose content is just updated
    */
     function saveExistingFile(filename, destinationDir) {

           /* console.log("Saving existing file..."); */

           /* path and fileName */
           var destinationFolder = "file://" + destinationDir + fileIO.getFullName(filename);

           /* dummy solution to prevent content append */
           if(fileIO.exists(destinationFolder)){
              fileIO.remove(destinationFolder)
           }

           var contentToSave;
           /* current file could be previously saved as Encrypted or not... */
           if(mainPage.fileEncrypted === true){
               contentToSave = encrypt(textArea.text, mainPage.encryptionPassword);
           }else{
              contentToSave = textArea.text;
           }

           fileIO.write(destinationFolder, contentToSave);
           showInfo(i18n.tr("Saved"));

           /* to prevent opening UnSavedDialog */
           mainPage.saved = true;
           currentFileOpenedLabel.color = UbuntuColors.green
       }

    /* show a Popup containing the provided in argument input */
    function showInfo(info) {
        infoText = "\n" + info + "\n";
        PopupUtils.open(popover);
    }

    SettingsPage {
       id: settingsPage
    }

    ProductInfoPage {
      id: productInfoPage
    }

    UnsavedDialog  {
       id: unsavedDialog;
       property Action closeAction
    }

    /* PopUp with the menu */
    Component {
       id: menuOptions
       MenuOptions{}
    }

    /* Ask for a web-site url to import as text in the textArea */
    Component {
       id: webSiteSelector
       WebSiteSelector{}
    }


    /* Ask for a web-site url to generate the associated QR Code */
    Component {
       id: qrCodeWebSiteSelector
       QrCodeWebSiteSelector{}
    }

    Component {
       id: saveAsDialog
       SaveAsDialog{}
    }

    Base64conversionPage {
      id: base64conversionPage
    }

    QrCodeGeneratorPage {
       id: qrCodeGeneratorPage
    }


    /* renderer for the entry in the Digest OptionSelector */
    Component {
        id: digestChooserDelegate
        OptionSelectorDelegate { text: name; }
    }

    Component {
         id: digestCalculatorChooser
         DigestCalculator{inputText: textArea.text}
    }


    PageStack {
        id: pageStack

        Component.onCompleted: {
            pageStack.push( mainPage )
        }

        /* Application main page */
        Page {

            id: mainPage
            anchors.fill: parent

            property Item textArea
            property bool saved: true /* a flag: true if file is NOT currently modified */
            property string openedFileName: ""  /* the currently opened file name */
            property bool currentFileLabelVisible: false /* to hide/show label with the current file name */
            property bool fileEncrypted: false /* set to "Encrypted" if the file is saved as encrypted */
            property string encryptionPassword: "" /* the encryptionkey of the currently opened file */

            header: PageHeader {

                id: header

                ClickableHeaderIcon {
                      id: about_button
                      iconSource: "menu.png"
                      text: i18n.tr("Menu")
                      anchors {
                          leftMargin: units.gu(1)
                          rightMargin: units.gu(5)
                          verticalCenter: header.verticalCenter
                      }
                      onTriggered: {
                         PopupUtils.open(menuOptions);
                      }
                }

                ClickableHeaderIcon {
                      id: settings_button
                      iconname: "settings"
                      text: i18n.tr("Settings")
                      anchors {
                          left: about_button.right
                          leftMargin: units.gu(3)
                          rightMargin: units.gu(2)
                          verticalCenter: header.verticalCenter
                      }
                      onTriggered: {
                         pageStack.push(settingsPage)
                         settingsPage.visible = true
                      }
                }

                Label {
                   id: titleLabel
                   text: i18n.tr("tedit")+ " "+root.appVersion
                   textSize: Label.Large
                   anchors {
                      horizontalCenter: header.horizontalCenter
                      verticalCenter: header.verticalCenter
                   }
                }

                ClickableHeaderIcon {
                        id: menu_button
                        iconcolor: UbuntuColors.green
                        iconSource: "tedit.png" //Qt.resolvedUrl("./graphics/menu.png")
                        text: i18n.tr("About")
                        anchors {
                              right: header.right
                              rightMargin: units.gu(3)
                              verticalCenter: header.verticalCenter
                         }
                         onTriggered: {
                             pageStack.push(productInfoPage)
                         }
                  }
         }

         Flickable {
               id: resultPageFlickable
               clip: true
               contentHeight: Utility.getContentHeight()
               anchors {
                      top: parent.top
                      left: parent.left
                      right: parent.right
                      bottom: mainPage.bottom
                      bottomMargin: units.gu(1)
               }

               Column {
                   id: mainPageLayout
                   anchors.fill: parent
                   spacing: units.gu(1)

                   anchors {
                      margins: units.gu(1)
                      topMargin: units.gu(7)
                   }

                   /* show the name of the currently opened file name */
                   Rectangle{
                         id: currentFileOpenedContainer
                         color: root.backgroundColor
                         width: parent.width
                         height: units.gu(3)

                         Label{
                            id: currentFileOpenedLabel
                            visible: mainPage.currentFileLabelVisible
                            anchors.verticalCenter: parent.verticalCenter
                            text: mainPage.openedFileName+"     ("+i18n.tr("saved")+": "+ mainPage.saved+")"
                            font.bold: true
                            /* happen when a new file is opened */
                            onTextChanged: {
                                currentFileOpenedLabel.color = UbuntuColors.green
                            }
                         }

                         Image {
                             id: padlockIcon
                             visible: mainPage.fileEncrypted
                             source: Qt.resolvedUrl("./graphics/encrypted.png")
                             height: units.gu(3)
                             width: units.gu(3)

                             anchors {
                                   left: currentFileOpenedLabel.right
                                   rightMargin: units.gu(2)
                                   verticalCenter: parent.verticalCenter
                             }
                          }


                   }


                   Rectangle{
                       id: textAreaContainer
                       width: parent.width
                       height: root.height - currentFileOpenedContainer.height - units.gu(12)
                       border.color : UbuntuColors.black
                       border.width : units.gu(2)

                       /* Display the file content */
                       TextArea {
                            id: textArea
                            width: parent.width
                            height: parent.height
                            textFormat: TextEdit.AutoText
                            font.pixelSize: settings.pixelSize
                            placeholderText: i18n.tr("Welcome ! Write what you want and save it. Enjoy !")
                            inputMethodHints: settings.textPrediction ? Qt.ImhMultiLine : Qt.ImhMultiLine | Qt.ImhNoPredictiveText
                            selectByMouse: true
                            onTextChanged: {
                               /* update flag file modified and not saved */
                               mainPage.saved = false;
                               currentFileOpenedLabel.color = '#A40000'
                            }
                            wrapMode: settings.wordWrap ? TextEdit.Wrap : TextEdit.NoWrap

                            Component.onCompleted: {
                                color =  settings.textAreaFontColor
                            }
                       }
                   }

                   Rectangle{
                       id:infoBarContainer
                       color: root.backgroundColor
                       width: parent.width
                       height: units.gu(3)
                       Label{
                          text: i18n.tr("Line")+": "+textArea.lineCount+ "  "+ i18n.tr("Characters")+": "+textArea.length
                          font.bold: true
                       }
                   }

                } //column

        } //flick

      }

   } //pageStack
}
