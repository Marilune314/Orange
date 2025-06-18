import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow {
    id:display
    signal screenSelected(var screen)
    width:600
    height:480
    visible:true
    title:qsTr("Set screen")
    Item {
        anchors.fill: parent
        focus: true
        Keys.onReturnPressed: okButton.clicked()
    SplitView{
        id:sv
        anchors.fill:parent
        orientation:Qt.Vertical
        //展示选中的屏幕
        Player{
            id:_player
            SplitView.preferredHeight: 230
            SplitView.minimumHeight: 230
            SplitView.fillHeight:true
            }
        //所有被捕获的屏幕的列表
        ScreenListView{
            id:_screenListView
            clip: true
            SplitView.preferredHeight:220
            SplitView.minimumHeight:200
            implicitWidth:300
        }
        // 使用Item作为容器包裹RowLayout
        Item {
          SplitView.preferredHeight:30
          id:_toolButtonListView
          SplitView.maximumHeight: 30
          RowLayout {
              anchors.right: parent.right
              anchors.verticalCenter: parent.verticalCenter
              spacing: 5

              Button {
                  id:okButton
                  text: qsTr("OK")
                  onClicked: screenSelected(_screenListView.targetScreen)
              }
              Button {
                text: qsTr("Cancel");
                onClicked: close()
            }
          }
      }
    }
}
}
