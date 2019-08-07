
/*
   Execute an Ajax call to read as text the content of the web site with the given url
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
