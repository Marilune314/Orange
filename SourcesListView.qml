import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item{
    property int chooseType
    //存储我所捕获的窗口
    property list<var> windowLists
    ColumnLayout{
        anchors.fill:parent
        //标签
        Label{
            text:"Sources"
            Layout.alignment: Qt.AlignTop
        }
        //列表
        ListView{
            id:_scourseListVeiw
            Layout.fillWidth:true
            Layout.fillHeight:true
            implicitWidth:300
            model:listModel
            delegate:Button{
                width:_scourseListVeiw.width
                Text{
                    anchors.centerIn: parent
                    text:model.name
                    color:"black"
                }
                onClicked:{
                    showPreview(index)
                }
            }
        }
        //工具栏
        ToolBar{
            Layout.alignment: Qt.AlignBottom
            Row{
                ToolButton{action:add_actions.add}
                ToolButton{action:add_actions.remove}
            }
        }
    }
    //列表数据
    ListModel{
        id:listModel
    }
    //上下文菜单
    Actions{
        id:add_actions
        screenCapture.onTriggered: {
            chooseType=1
            loderNewCapture.source="NewWindow.qml"
        }
        windowCapture.onTriggered: {
            chooseType=2
            loderNewCapture.source="NewWindow.qml"
        }
    }
    //加载NewWindow.qml
    Loader{
        id:loderNewCapture
        onLoaded: {
            item.chooseType = chooseType
            item.completed.connect(function(deviceName, capturedWindow) {
                        listModel.append({"name": deviceName});
                        windowLists.push(capturedWindow);
                        loderNewCapture.source = ""
                    })



        }

    }
    function showPreview(index){
        _mainplayer.startPreviewWindow(windowLists[index])
    }
}

