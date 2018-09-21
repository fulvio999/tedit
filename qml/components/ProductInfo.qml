import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3



/* General info about the application */
Dialog {
       id: aboutDialogue
       title: i18n.tr("Product Info")
       text: "tedit: "+ i18n.tr("version")+ ":"+root.appVersion+"<br>"+ i18n.tr("Author")+": "+"fulvio"+"<br><br>"+
             i18n.tr("A simple and basic text, notes editor")+"<br><br>"+
             i18n.tr("Thanks at jshashes library for hash Algorithm")+".<br> "+" https://github.com/h2non/jshashes"
       Button {
           text:  i18n.tr("Close")
           onClicked: PopupUtils.close(aboutDialogue)
       }
}
