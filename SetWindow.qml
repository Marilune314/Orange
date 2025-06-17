import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow {
    id:setWinodw
    signal windowSelected(var window)
    width:600
    height:480
    visible:true
    SplitView{
        id:sv
        anchors.fill:parent
        orientation:Qt.Vertical
        //展示选中的窗口
        Player{
            id:_player
            SplitView.preferredHeight:230 // 初始宽度
            SplitView.minimumHeight: 230
            SplitView.fillHeight:true
            }
        //所有被捕获的窗口的列表
        WindowListView{
            id:_windowListView
            clip: true
            SplitView.preferredHeight:220
            SplitView.minimumHeight:220
            implicitWidth:300
        }
        // 使用Item作为容器包裹RowLayout
        Item {
            SplitView.preferredHeight:30
            id:_toolButtonListView
            SplitView.maximumHeight: 30  // 给足够的高度
            RowLayout {
                anchors.right: parent.right  // 靠右对齐
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5  // 设置按钮间距
                Button {
                    text: qsTr("OK")
                    //直接让我listview中选择好的屏幕可以传给newwindow调用窗口
                    onClicked:windowSelected(_windowListView.window)}
                Button {
                    text: qsTr("Cancel")
                }
            }
        }
     }
}
