function showPreview(index) {
    if (index >= 0 && index <captureLists.length) {
        var item =captureLists[index]
        switch(item.type) {
        case "screen":
            player.startPreviewScreen(item.data)
            break
        case "window":
            player.startPreviewWindow(item.data)
            break
        default:
            console.error("unknown type:", item.type)
        }
    }
}

function getOutputPath(fileName) {
            var dir = StandardPaths.writableLocation(StandardPaths.MoviesLocation)+"/ScreenCaptureFiles"
            if(fileHelper.ensureDirExists(dir.toString().replace("file://","")))
                return dir+"/"+fileName
}
function stopButton(){
    var path=getOutputPath("Screen_Capture_" + Qt.formatDateTime(new Date(), "yyyyMMdd_hhmmss") + ".mp4");
    recorder.stopRecording(path);
    return path;
}

