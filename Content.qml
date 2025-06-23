import QtQuick
import QtQuick.Controls
import QtCore
import Orange 1.0
import "Controller.js" as Controller
Item{
    property alias player:_mainplayer
    property alias sourcesListView:_sourcesListView
    property alias toolButtonListView: _toolButtonListView
    property  alias dialogs:_dialogs
    property alias localPlayer:_localPlayer
    property alias fileHelper: _fileHelper
    property alias recorder: _recorder
    property string path:""
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
                      if(_sourcesListView.listModel.count===0){
                          _dialogs.checkSourceDialog.open()
                      }else{
                          console.log(_sourcesListView.windowId)
                          recorder.startRecording(_sourcesListView.windowId);
                      }
               }
               pauseButton.onClicked:{ recorder.pauseRecording();}
               pauseButton.onDoubleClicked: {recorder.resumeRecording(_sourcesListView.windowId);}
               stopButton.onClicked:{
                   path=Controller.stopButton()}
            }

        }
    }
    Dialogs{
        id:_dialogs
    }

    LocalPlayer{
       id:_localPlayer
    }

    function tryStartRecording(): bool {
        if (_sourcesListView.listModel.count === 0) {
            _dialogs.checkSourceDialog.open();
            return false;
        } else {
            return true;
        }
    }
    FileHelper{
        id:_fileHelper
    }
    Recorder{
        id:_recorder
    }

}
