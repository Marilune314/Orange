import QtQuick
import QtMultimedia
import QtQuick.Window
Item {
    //anchors.fill:parent
    property alias captureSession:_captureSession

    function startPreviewWindow(capturableWindow) {
            windowCapture.active = false
            windowCapture.window = capturableWindow;
            windowCapture.active = true;  // 激活捕获
    }

    CaptureSession{
        id:_captureSession
        screenCapture:ScreenCapture{id:screenCapture;active:false}
        windowCapture:WindowCapture{id:windowCapture;active:false}
        audioInput:AudioInput{id:audioInput}
        videoOutput:_videoOutput
        recorder:null
    }
    VideoOutput{
        id:_videoOutput
        anchors.fill:parent
    }

}
