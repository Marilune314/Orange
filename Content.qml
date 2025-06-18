import QtQuick
import QtQuick.Controls
import QtCore
import "Controller.js" as Controller
Item{
    property alias player:_mainplayer
    property alias sourcesListView:_sourcesListView
    property alias toolButtonListView: _toolButtonListView
    property  alias dialogs:_dialogs
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
                          path=Controller.startButton()
                      }


               }
               pauseButton.onClicked: _mainplayer.captureSession.recorder.pause()
               stopButton.onClicked:_mainplayer.captureSession.recorder.stop();

            }

        }
    }
    Dialogs{
        id:_dialogs
    }

}
