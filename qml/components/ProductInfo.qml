import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


/* General info about the application */
Dialog {
       id: aboutDialogue
       title: i18n.tr("Product Info")
       text: "tedit: "+ i18n.tr("version")+ ":"+root.appVersion+"<br>"+ i18n.tr("Author")+": "+"fulvio"+"<br><br>"+
             i18n.tr("A simple and basic text, notes editor")+"<br><br>"+
             i18n.tr("Thanks at jshashes library for hash Algorithm")+".<br>"+" https://github.com/h2non/jshashes"+"<br><br>"+
             i18n.tr("Thanks at")+":<br>"+ "https://github.com/mathiasbynens/base64"+"<br>"+i18n.tr("for Base64 encoder/decoder")+"<br><br>"+
              i18n.tr("Thanks at")+":<br>"+"M4rtinK "+"https://github.com/M4rtinK"+"<br>"+"for QML binding at qr.js library and qr.js library developers"
       Button {
           text:  i18n.tr("Close")
           onClicked: PopupUtils.close(aboutDialogue)
       }
}
