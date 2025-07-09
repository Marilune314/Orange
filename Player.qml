// Written by WXR HJX YJY
// date 2025-7-9
// player.qml of the Screen Recorder application
import QtQuick
import QtMultimedia
import QtQuick.Window
import QtQuick.Dialogs

Item {
    property alias captureSession:_captureSession
    property string errorinfo
    function startPreviewWindow(capturableWindow) {
            screenCapture.active=false
            windowCapture.active = false
            windowCapture.window = capturableWindow;
            windowCapture.active = true;  // 激活捕获
    }
    function startPreviewScreen(capturableScreen) {
            windowCapture.active=false
            screenCapture.active = false
            screenCapture.screen = capturableScreen;
            screenCapture.active = true;  // 激活捕获
    }

    CaptureSession{
        id:_captureSession
        screenCapture:ScreenCapture{id:screenCapture;active:false}
        windowCapture:WindowCapture{
            id:windowCapture;
            active:false;
            onErrorChanged:{
                if(windowCapture.error!==WindowCapture.NoError)
                {
                     errorinfo=errorString;
                     _warning.open();
                }
            }
        }
        audioInput:AudioInput{id:audioInput}
        videoOutput:_videoOutput
        recorder: null
    }
    VideoOutput{
        id:_videoOutput
        anchors.fill:parent
    }
    MessageDialog{
        id:_warning
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"QScreenCapture: Error occurred"
        informativeText:errorinfo
    }
    Rectangle{
        id:_placeHold
        anchors.fill: parent
        color:"black"
        visible: (windowCapture.active || screenCapture.active)?false:true
        Text {
            anchors.centerIn: parent
            text: qsTr("No preview available.\nClick a source to display.")
            color: "gray"
            font {
                pixelSize: 24
                italic: true
                weight: Font.Normal
            }
        }
    }

}
