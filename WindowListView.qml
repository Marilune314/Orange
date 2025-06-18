import QtQuick
import QtQuick.Controls
import Orange 1.0
import QtQuick.Layouts
ListView{
    //在listview中被选中的项的window窗口
    property var window
    id:_windowlistView
    model:WindowListModel{}
    cacheBuffer:100
    delegate:
        Rectangle{
            width: _windowListView.width
            height:20
            Text{
                anchors.margins: 4
                width:100
                text:model.display
                color: "black"
                }
            TapHandler{
                onTapped:{
                    // 获取当前点击的窗口对象
                    window = _windowListView.model.getWindow(index);
                    // 调用 Player 的预览方法
                    if (window.isValid) {
                        _player.startPreviewWindow(window);
                    }

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
