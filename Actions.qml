import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
Item {
    property alias show:_show
    property alias about:_about
    property alias add:_add
    property alias remove: _remove
    property alias screenCapture:_screenCapture
    property alias windowCapture:_windowCapture
    MessageDialog{
        id:_aboutDialog
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"This is a simple screen recorder."
        informativeText: qsTr("Orange is a free software, and you can download its source code from www.open-src.com")
        detailedText: "Copyright©2025 HuJunxin WangXinru YangJiayi"
    }

    Action{
        id:_show
        icon.name: "media-playback-start"
        text:"Play(existing files)"
    }
    Action{
        id:_about
        icon.name:"help-about"
        text:"About"
        onTriggered: {
            _aboutDialog.open()
        }
    }
    Action{
        id:_add
        icon.name:"list-add"
        onTriggered:contextMenu.popup()
    }
    Action{
        id:_remove
        icon.name:"edit-delete"
    }
    Menu{
           id: contextMenu
           MenuItem { action:_screenCapture }
           MenuItem { action:_windowCapture}
    }
    Action{
        id:_screenCapture
        text:"Screen Capture"
    }
    Action{
        id:_windowCapture
        text:"Window Capture"
    }

}
