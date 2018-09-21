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

          /* the text to calculate di digest (ie: input textArea content) */
          property string inputText : "";

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
               width: digestPickerDialog.width
               height: digestPickerDialog.height/4

               /* Display the file content */
               TextArea {
                    id: digestResultTextArea
                    width: parent.width
                    height: parent.height
                    textFormat: TextEdit.AutoText
                    readOnly: true
                    //placeholderText: i18n.tr("Digest")
                    inputMethodHints: Qt.ImhNoPredictiveText
                    selectByMouse: true
                    wrapMode: settings.wordWrap ? TextEdit.Wrap : TextEdit.NoWrap
               }
           }

           Row{
               spacing:units.gu(2)
               anchors.horizontalCenter: parent.horizontalCenter

               Button {
                     text: i18n.tr("Calculate")
                     width: units.gu(14)
                     color: UbuntuColors.green
                     onClicked: {

                                var chosenDigester = digesterCalculatorListModel.get(digestChooserSelector.selectedIndex).name;
                                console.log('chosen Digester: ' + chosenDigester);
                                console.log('Input text: ' + digestPickerDialog.inputText);

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
                                         console.log("ERORR, Algorithm not selected or unsupportded value");
                                         digestResultTextArea.text = i18n.tr("ERORR, Algorithm not selected or unsupportded value");
                                    }

                                }else{
                                   digestResultTextArea.text = i18n.tr("Input is empty !");
                                }

                             }
                     }

                     Button {
                         text: i18n.tr("Close")
                         width: units.gu(14)
                         onClicked: {
                             PopupUtils.close(digestPickerDialog)
                         }
                     }
                 }
             }
