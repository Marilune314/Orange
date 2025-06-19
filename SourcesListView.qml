import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Controller.js" as Controller
Item{
    property int chooseType
    property alias listModel:listModel
    //存储我所捕获的窗口
    property list<var> captureLists
    ColumnLayout{
        anchors.fill:parent
        //标签
        Label{
            text:"Sources: Click to preview"
            Layout.alignment: Qt.AlignTop
        }
        //列表
        ListView{
            id:_sourceListView
            Layout.fillWidth:true
            Layout.fillHeight:true
            implicitWidth:300
            visible: listModel.count===0?false:true
            model:listModel
            delegate:
                ItemDelegate{
                property bool isCurrent: ListView.isCurrentItem

                highlighted: isCurrent
                width:_sourceListView.width
                Text{
                    anchors.centerIn: parent
                    text:model.name
                    color:Qt.styleHints.colorScheme === Qt.Light ? "black" : "white"
                }
                onClicked:{
                    _sourceListView.currentIndex=index;
                    Controller.showPreview(index)
                }

            }
        }
        Rectangle{
            id:_placeHold
            Layout.fillWidth:true
            Layout.fillHeight:true
            implicitWidth:300
            visible: _sourceListView.visible?false:true
            Text {

                anchors.centerIn: parent
                text: qsTr("no exist source\nplease click '+'")
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
                    });
            item.closing.connect(function() {
                    loadNewCapture.source = ""
                                })



        }

    }



}


