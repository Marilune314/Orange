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
            var dir = StandardPaths.writableLocation(StandardPaths.MoviesLocation)
            return dir+"/"+fileName
}
function startButton(){
    var recorder = Qt.createQmlObject('import QtMultimedia 6.0; MediaRecorder {}',
                                         player.captureSession,
                                         "dynamicRecorder");
    var path=getOutputPath("Screen_Capture_" + Qt.formatDateTime(new Date(), "yyyyMMdd_hhmmss") + ".mp4");
    recorder.outputLocation=path;
    recorder.videoBitRate =8000*1000
    recorder.videoFrameRate=30
    recorder.videoResolution ="1920x1080"
    recorder.audioBitRate=128000
    player.captureSession.recorder = recorder;
    player.captureSession.recorder.record();
    return path;
}

