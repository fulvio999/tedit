import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/* digest calculator functions */
import "../js/hashes.js" as Hashes

  Dialog {
          id: digestPickerDialog
          contentWidth: units.gu(42)

          title: i18n.tr("Found")+": "+digesterCalculatorListModel.count +" "+i18n.tr("digesters")
          text: i18n.tr("Calculate the digest of the note")

          /* the text to calculate the digest (ie: input textArea content) */
          property string inputText : "";

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

          /* digester algorithm chooser */
          OptionSelector {
                 id: digestChooserSelector
                 expanded: true
                 multiSelection: false
                 delegate: digestChooserDelegate
                 model: digesterCalculatorListModel
                 containerHeight: itemHeight * 5

                 /* clear old output */
                 onDelegateClicked: {
                    digestResultTextArea.text = "";
                 }
           }

           Rectangle{
               id: textAreaContainer
               color: root.backgroundColor
               width: digestPickerDialog.width
               height: digestPickerDialog.height/5

               /* Display the digest calculation result */
               TextArea {
                    id: digestResultTextArea
                    width: parent.width
                    height: units.gu(18) //parent.height
                    textFormat: TextEdit.AutoText
                    readOnly: true
                    inputMethodHints: Qt.ImhNoPredictiveText
                    selectByMouse: true
                    wrapMode: settings.wordWrap ? TextEdit.Wrap : TextEdit.NoWrap
               }

               Button{
                    id:addResultToNoteButton
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: units.gu(1)
                        topMargin: units.gu(3)
                        horizontalCenter: parent.horizontalCenter
                    }
                    visible: false /* visible after calculation */
                    text: i18n.tr("Copy to note")
                    width: units.gu(15)
                    onClicked: {
                          textArea.text = textArea.text + digestResultTextArea.text
                          pageStack.push(mainPage)
                          PopupUtils.close(digestPickerDialog)
                    }
               }
           }

           Row{
               spacing:units.gu(1)
               anchors.horizontalCenter: parent.horizontalCenter

               Button {
                     text: i18n.tr("Calculate")
                     width: units.gu(16)
                     color: UbuntuColors.green
                     onClicked: {

                                var chosenDigester = digesterCalculatorListModel.get(digestChooserSelector.selectedIndex).name;
                                //console.log('chosen Digester: ' + chosenDigester);
                                //console.log('Input text o digest: ' + digestPickerDialog.inputText);

                                if( digestPickerDialog.inputText.length > 0) {

                                    if(chosenDigester ==='MD5'){
                                        var MD5 = new Hashes.MD5();
                                        digestResultTextArea.text = MD5.hex(digestPickerDialog.inputText);

                                    }else if(chosenDigester ==='SHA-1'){
                                        var SHA1 = new Hashes.SHA1();
                                        digestResultTextArea.text = SHA1.hex(digestPickerDialog.inputText);

                                    }else if(chosenDigester ==='SHA-512'){
                                         var SHA512 = new Hashes.SHA512();
                                         digestResultTextArea.text = SHA512.hex(digestPickerDialog.inputText);

                                    }else if(chosenDigester ==='SHA-256'){
                                         var SHA256 = new Hashes.SHA256();
                                         digestResultTextArea.text = SHA256.hex(digestPickerDialog.inputText);

                                    }else if(chosenDigester ==='RMD-160'){
                                         var RMD160 = new Hashes.RMD160();
                                         digestResultTextArea.text = RMD160.hex(digestPickerDialog.inputText);
                                    }else{
                                         console.log("ERROR, Algorithm not selected or unsupported value");
                                         digestResultTextArea.text = i18n.tr("ERROR, Algorithm not selected or unsupportded value");
                                    }

                                    addResultToNoteButton.visible = true

                                }else{
                                   digestResultTextArea.text = i18n.tr("Notes area is empty !");
                                }
                           }
                    }

                    Button {
                           anchors.horizontalCenter: parent.Center
                           text: i18n.tr("Close")
                           width: units.gu(16)
                           onClicked: {
                               PopupUtils.close(digestPickerDialog)
                           }
                    }
            }
    }
