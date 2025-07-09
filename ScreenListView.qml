// Written by WXR HJX YJY
// date 2025-7-9
// screenlistView.qml of the Screen Recorder application
import QtQuick
import QtQuick.Layouts
import QtMultimedia
import Orange 1.0
ListView{
    property var targetScreen
    id:_screenListView
    model:ScreenListModel{}
    cacheBuffer:100
    delegate:Rectangle{
        width:_screenListView.width
        height:20
        Text
        {
            anchors.margins:4
            width: 100
            text:model.display
            color: "black"
        }
        TapHandler{
            onTapped: {
                var scrs = Application.screens
                targetScreen=scrs[index]
                if (targetScreen) {
                    _player.startPreviewScreen(targetScreen)
                } else {
                    console.error("not find Screen Object")
                }

            }
        }

    }

}

