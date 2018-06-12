
/*
   With an Ajax call read as text the contnet of a web site whoes url is in argument
 */
function importSiteText(url) {
        var doc = new XMLHttpRequest();      
        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.DONE) {
                textArea.text = doc.responseText;
                PopupUtils.close(importDialogue)
            }
        }
        doc.open("get", url);
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
}
