import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item{
    property int chooseType
    //存储我所捕获的窗口
    property list<var>captureLists
    ColumnLayout{
        anchors.fill:parent
        //标签
        Label{
            text:"Sources:"
            Layout.alignment: Qt.AlignTop
        }
        //列表
        ListView{
            id:_sourceListView
            Layout.fillWidth:true
            Layout.fillHeight:true
            implicitWidth:300
            model:listModel
            delegate:Button{
                width:_sourceListView.width
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
            loadNewCapture.source="NewWindow.qml"
        }
        windowCapture.onTriggered: {
            chooseType=2
            loadNewCapture.source="NewWindow.qml"
        }
        remove.onTriggered: {
            listModel.remove(_sourceListView.currentIndex,1)
            captureLists.splice(_sourceListView.currentIndex,1)
        }

    }
    //加载NewWindow.qml
    Loader{
        id:loadNewCapture
        onLoaded: {
            item.chooseType = chooseType
            item.completed.connect(function(deviceName, capturedItem) {
                        listModel.append({
                                             "name": deviceName,
                                             "type": chooseType===1?"screen":"window"
                                        });
                       captureLists.push({
                                            "data":capturedItem,
                                            "type":chooseType===1?"screen":"window"
                                        });
                        loadNewCapture.source = ""
                    })



        }

    }

    function showPreview(index) {
        if (index >= 0 && index <captureLists.length) {
            var item =captureLists[index]
            switch(item.type) {
            case "screen":
                _mainplayer.startPreviewScreen(item.data)
                break
            case "window":
                _mainplayer.startPreviewWindow(item.data)
                break
            default:
                console.error("unknown type:", item.type)
            }
        }
    }

}

