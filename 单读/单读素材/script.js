function highlite(){
    var sel = window.getSelection();
    if (!sel.isCollapsed) {
        var selRange = sel.getRangeAt(0);
        document.designMode = "on";
        sel.removeAllRanges();
        sel.addRange(selRange);
        document.execCommand("Underline");
        sel.removeAllRanges();
        document.designMode = "off";
    }
}