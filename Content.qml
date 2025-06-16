import QtQuick
import QtQuick.Controls

Item{
    property alias player:_mainplayer
    property alias sourcesListView:_sourcesListView
    property alias toolButtonListView: _toolButtonListView
    SplitView{
        id:sv
        anchors.fill:parent
        orientation:Qt.Vertical
        Player{
            id:_mainplayer
            SplitView.preferredHeight: 440 // 初始宽度
            SplitView.fillHeight: true
            }
        SplitView{
            SplitView.fillWidth: true
            SplitView.preferredHeight:200
            orientation:Qt.Horizontal

            SourcesListView{
                id:_sourcesListView
                SplitView.preferredWidth:parent.width/2
            }

            ToolButtonListView{
                  id:_toolButtonListView
                  SplitView.preferredWidth:parent.width/2
                  //动态创建recorder对象
                  startButton.onClicked:{
                  var recorder = Qt.createQmlObject('import QtMultimedia 6.0; MediaRecorder {}',
                                                       _mainplayer.captureSession,
                                                       "dynamicRecorder");
                  recorder.outputLocation="file:///root/recording.mp4";
                  _mainplayer.captureSession.recorder = recorder;
                  _mainplayer.captureSession.recorder.record();
               }
               pauseButton.onClicked: _mainplayer.captureSession.recorder.pause()
               stopButton.onClicked:_mainplayer.captureSession.recorder.stop();

            }

        }
    }



}
