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


    Action{
        id:_show
        icon.name: "media-playback-start"
        text:"Play(existing files)"
    }
    Action{
        id:_about
        icon.name:"help-about"
        text:"About"

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
