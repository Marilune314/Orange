import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item{
    property int chooseType
    ColumnLayout{
        anchors.fill:parent

        Label{
            text:"Sources"
            Layout.alignment: Qt.AlignTop
        }

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
            }
        }

        ToolBar{

            Layout.alignment: Qt.AlignBottom
            Row{
                ToolButton{action:add_actions.add}
            }
        }
    }
    ListModel{
        id:listModel
    }

    Actions{
        id:add_actions
        displayCapture.onTriggered: {
            chooseType=1
            loderNewCapture.source="NewWindow.qml"
        }
        windowCapture.onTriggered: {
            chooseType=2
            loderNewCapture.source="NewWindow.qml"
        }
        audioInputCapture.onTriggered: {
            loderNewCapture.source="NewWindow.qml"
        }
        audioOutputCapture.onTriggered: {
            loderNewCapture.source="NewWindow.qml"
        }
    }

    Loader{
        id:loderNewCapture
        onLoaded: {
            item.chooseType=chooseType
            // listModel.append({"name":item.deviceName})
            // loderNewCapture.source=""
            item.deviceName.connect(function(name){
                listModel.append({"name":name})
                loderNewCapture.source=""
            }
                )
            // if(chooseType===2){
            //     _mainplayer.startPreviewWindow(item.chooseWindow)
            // }

        }

    }
}
