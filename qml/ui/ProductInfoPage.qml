import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../js/Utility.js" as Utility


/* General info about the application */
Page {
     id: productInfoPage

     header: PageHeader {
        title: i18n.tr("Product Info")
     }

     visible: false

     Flickable {
           id: productInfoPageFlickable
           clip: true
           contentHeight: Utility.getContentHeight()
           anchors {
                  top: parent.top
                  left: parent.left
                  right: parent.right
                  bottom: productInfoPage.bottom
                  bottomMargin: units.gu(1)
                  topMargin: units.gu(7)
           }

       Column {
             id: mainPageLayout
             anchors.fill: parent
             spacing: units.gu(1)

                      TextArea {
                              anchors.fill: parent
                              textFormat: TextEdit.RichText
                              readOnly: true
                              text: "tedit  "+ i18n.tr("version")+ ": "+root.appVersion+"<br>"+
                                       i18n.tr("Author")+": "+"fulvio"+"<br><br>"+
                                       i18n.tr("Thanks at")+":"+"<br>"+
                                       "<b>1)</b> "+i18n.tr("jshashes library for hash Algorithm")+".<br>"+" https://github.com/h2non/jshashes "+"<br>"+
                                       "<b>2)</b> "+i18n.tr("Developers of")+" https://github.com/mathiasbynens/base64 "+i18n.tr("for Base64 features")+"<br>"+
                                       "<b>3)</b> "+"M4rtinK "+"https://github.com/M4rtinK "+"<br>"+i18n.tr("for QML binding for qr.js lib")+"<br>"+
                                       "<b>4)</b> "+i18n.tr("Developers of library")+": CriptoJS "+"<br><br>"+
                                       "<b>"+i18n.tr("IMPORTANT notes for Encrypted files")+":</b>"+"<br><br>"+
                                       "<b>"+i18n.tr("If the encryption key is lost, there is NO restore. The file remains encrypted")+"</b>"+"<br>"+
                                       "<b>"+i18n.tr("Author has no responsibility")+"</b>"+"<br>"+
                                       i18n.tr("Suggestion: use the same key for all the files to be saved with encryption")+"<br>"+
                                       i18n.tr("instead of different ones so that you need to remember just one key")+"<br>"+
                                       "<b>"+i18n.tr("Encrypted file names have XXX suffix to distinguish them")+".<b>"+"<br>"+
                                       "<b>"+i18n.tr("A padlock is shown when an encrypted file is currently opened")+"<b>"
                        }
           }
    }

    Scrollbar {
         flickableItem: productInfoPageFlickable
         align: Qt.AlignTrailing
    }

}
