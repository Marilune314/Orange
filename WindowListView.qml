// Written by WXR HJX YJY
// date 2025-7-9
// windowListView.qml of the Screen Recorder application
import QtQuick
import QtQuick.Controls
import Orange 1.0
import QtQuick.Layouts
ListView{
    //在listview中被选中的项的window窗口
    property var window
    property var window_id
    id:_windowlistView
    model:WindowListModel{}
    cacheBuffer:100
    delegate:
        Rectangle{
            width: _windowListView.width
            height:20
            color: ListView.isCurrentItem ? "light blue" : "white"
        Text{
            anchors.margins: 4
            width:100
            text:model.display
            color: "black"
            }
            TapHandler{
                onTapped:{
                    _windowListView.currentIndex=index
                   // 获得当前点击的窗口对象
                    window = _windowListView.model.getWindow(index);
                   // 调用Player 的预览方法
                    if (window.isValid) {
                        _player.startPreviewWindow(window);
                    }
                    window_id="0x"+model.windowId.toString(16);
                    // console.log(window_id)
                }
            }
        }
    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: {
            updatewindow.popup();
        }
    }
    Menu{
        id:updatewindow
        MenuItem{
            text:"UpdateWindow"
            onTriggered:model.populate()
        }

    }
}
