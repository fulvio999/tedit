import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "../components"
import "../js/qqr.js" as QRCodeBackend

/*
  Page where is shown the QR Code associated at the chosen url
*/
Page {
       id: qrCodeGeneratorPage
       /* the url to represent with a QR Code */
       property string pageUrl;

       anchors.fill: parent
       visible: false

       header: PageHeader {
           id: header
           title: i18n.tr("Page")+": "+pageUrl
       }

       QRCode {
            id: qrcodeComponent
            anchors.top : header.bottom
            anchors.topMargin : units.gu(4)
            anchors.leftMargin : units.gu(4)
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.verticalCenter : parent.verticalCenter

            width : parent.width - units.gu(3)
            height : parent.height - units.gu(3)
            value : pageUrl
            level : "H"
      }
}
